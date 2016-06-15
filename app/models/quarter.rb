  # == Schema Information
#
# Table name: quarters
#
#  id         :integer          not null, primary key
#  quarter    :integer          not null
#  year       :integer          not null
#  is_public  :boolean          default(FALSE)
#  slug       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'csv'
class Quarter < ActiveRecord::Base

  #######################
  ## ATTACHED FILE
  has_attached_file :report,
                    :url => "/system/quarterly_reports/:quarter_slug/:basename_:locale.:extension",
                    :use_timestamp => false

  #######################
  ## TRANSLATIONS

  translates :summary_good, :summary_bad,
    :report_file_name, :report_file_size, :report_content_type, :report_updated_at, :fallbacks_for_empty_translations => true
  globalize_accessors

  #######################
  ## RELATIONSHIPS
  has_one :expert_survey, dependent: :destroy
  has_many :reform_surveys, dependent: :destroy
  has_many :news, dependent: :destroy

  accepts_nested_attributes_for :expert_survey, reject_if: :all_blank
  accepts_nested_attributes_for :reform_surveys, reject_if: :all_blank

  #######################
  ## VALIDATIONS

  validates :quarter, :year, :slug, presence: :true
  validates_uniqueness_of :year, scope: :quarter
  validates_uniqueness_of :slug
  validates_inclusion_of :quarter, in: 1..4
  validates_inclusion_of :year, in: 2015..2115

  validates_attachment_content_type :report, :content_type => 'application/pdf'
  validate :check_if_can_publish


  # if the is_public flag chnaged to true, make sure everything is in place in order to publish
  # - report
  # - expert survey
  # - at least one reform
  def check_if_can_publish
    if self.is_public_changed? and self.is_public?
      if !self.report.exists?
        errors.add(:base, I18n.t('errors.messages.publish.report') )
      end

      if !self.expert_survey.present?
        errors.add(:base, I18n.t('errors.messages.publish.expert_survey') )
      end

      if !self.reform_surveys.present?
        errors.add(:base, I18n.t('errors.messages.publish.reform_survey') )
      end

    end
    return true
  end

  #######################
  ## SLUG DEFINITION (friendly_id)

  extend FriendlyId
  friendly_id :slug_candidates, use: [:slugged, :history]

  # the slug should be: year-quarter
  def slug_candidates
    [
      [:time_period],
      [:quarter, :year]
    ]
  end

  # for genereate friendly_id
  def should_generate_new_friendly_id?
    quarter_changed? || year_changed? || super
  end

  # for locale sensitive transliteration with friendly_id
  def normalize_friendly_id(input)
    input.to_s.to_slug.normalize.to_s
  end

  #######################
  ## SCOPES
  scope :published, -> { where(is_public: true) }
  scope :recent, -> {order(year: :desc, quarter: :desc)}
  scope :oldest, -> {order(year: :asc, quarter: :asc)}
  scope :with_expert_survey, -> {includes(expert_survey: [:translations] )}
  scope :with_reform_surveys, -> {includes(reform_surveys: [:translations] )}
  scope :with_news, -> {includes(news: [:translations] )}

  # get the latest quarter
  def self.latest
    published.recent.first
  end

  # get an array of the active quarters in format: [time period, slug]
  def self.active_quarters_array
    published.recent.map{|x| [x.time_period, x.slug]}
  end

  # get all quarters with the provided ids
  def self.with_ids(quarter_ids)
    where(id: quarter_ids)
  end

  #######################
  ## METHODS

  # formal name of quarter: Q# 2016
  def time_period
    "#{formatted_quarter} #{self.year}"
  end

  def formatted_quarter
    I18n.t('shared.common.formatted_quarter', quarter: self.quarter)
  end

  def set_reform(reform_slug)
    reform = Reform.friendly.find(reform_slug)
    if reform
      reform_id = reform.id
    end
  end

  # you must set the reform first before calling this
  def self.reform_survey
    reform_surveys.where(reform_id: reform_id).first
  end


  # expert columns: quarter, year, time period, overall, cat1, cat2, cat3
  # reform columns: quarter, year, time period, govt overall, govt cat1, govt cat2, govt cat3, govt cat4, stakeholder cat1, stakeholder cat2, stakeholder cat3
  def self.to_csv(type='expert', reform_id=nil)
    if type == 'reform' && reform_id.present?
      # get all of the survey results for this reform
      surveys = ReformSurvey.for_reform(reform_id)

      header = %w{quarter year time_period government_overall_score government_insitutional_setup_score government_capacity_building_score government_infastructure_budgeting_score government_legislation_regulations_score stakholder_overall_score stakholder_performance_score stakholder_goals_score stakholder_progress_score }

      CSV.generate do |csv|
        csv << header

        published.recent.each do |q|
          survey = surveys.select{|x| x.quarter_id == q.id}.first
          if survey
            csv << [
                    q.quarter, q.year, q.time_period,
                    survey.government_overall_score, survey.government_category1_score, survey.government_category2_score, survey.government_category3_score, survey.government_category4_score,
                    survey.stakeholder_overall_score, survey.stakeholder_category1_score, survey.stakeholder_category2_score, survey.stakeholder_category3_score
                  ]
          end
        end
      end

    else

      header = %w{quarter year time_period overall_score performance_score goals_score progress_score}
      CSV.generate do |csv|
        csv << header

        published.recent.with_expert_survey.each do |q|
          csv << [q.quarter, q.year, q.time_period, q.expert_survey.overall_score, q.expert_survey.category1_score, q.expert_survey.category2_score, q.expert_survey.category3_score]
        end
      end
    end
  end


  # get the expert survey data for all quarters
  # formatted in hash/json format
  # format: {title, subtitle, min, max, categories: [x-axis labels], series: [{name: 'name', data: [ {y, change} ] } ] }
  # options:
  # - overall_score_only - indicates whether just the overall score should be returned or overall and all category scores (default false)
  # - is_published - indicates if just the published quarters should be returned (default true)
  def self.expert_survey_data_for_charting(options={})
    default_options = {overall_score_only: false, is_published: true}
    options = options.reverse_merge(default_options)

    hash = {
      title: I18n.t('shared.chart_titles.expert.title'),
      id: options[:id],
      subtitle: nil,
      min: 0,
      max: 10,
      categories: [],
      series: []
    }

    quarters = oldest
    quarters = quarters.published if options[:is_published]

    if quarters.present?
      # load the x-axis labels (categories)
      hash[:categories] = quarters.map{|x| x.time_period}

      # get the data
      # overall
      hash[:series] << {
        name: I18n.t('shared.categories.overall'),
        type: 'areaspline',
        data: quarters.map{|x| {y: x.expert_survey.overall_score.to_f, change: x.expert_survey.overall_change}}}

      if !options[:overall_score_only]
        # category 1
        hash[:series] << {
          name: I18n.t('shared.categories.performance'),
          dashStyle: 'longDash',
          data: quarters.map{|x| {y: x.expert_survey.category1_score.to_f, change: x.expert_survey.category1_change}}
        }
        # category 2
        hash[:series] << {
          name: I18n.t('shared.categories.goals'),
          dashStyle: 'shortDash',
          data: quarters.map{|x| {y: x.expert_survey.category2_score.to_f, change: x.expert_survey.category2_change}}
        }
        # category 3
        hash[:series] << {
          name: I18n.t('shared.categories.progress'),
          dashStyle: 'dot',
          data: quarters.map{|x| {y: x.expert_survey.category3_score.to_f, change: x.expert_survey.category3_change}}
        }
      end
    end

    return hash
  end


  # get the reform survey data for all quarters for all reforms
  # formatted in hash/json format
  # format: {type, title, subtitle, min, max, categories: [x-axis labels], series: [{name: 'name', color: rgb(), data: [ {y, change} ] } ] }
  # options:
  # - type: indicate if want government or stakeholder data (default government)
  # - is_published - indicates if just the published quarters should be returned (default true)
  def self.all_reform_survey_data_for_charting(options={})
    default_options = {type: 'government', is_published: true, overall_score_only: true, quarter_ids: nil}
    options = options.reverse_merge(default_options)

    hash = {
      type: nil,
      title: nil,
      id: options[:id],
      subtitle: nil,
      min: nil, max: nil, categories: [], series: []
    }
    # quarters = oldest
    # quarters = quarters.published if options[:is_published]

    # # get all of the survey results for this reform
    # surveys = ReformSurvey.for_reform(reform_id)

    reforms = Reform.active

    # get data for all reforms
    data = []
    if reforms.present?
      reforms.each do |reform|
        data << reform_survey_data_for_charting(reform.id, options)
      end
    end

    # put together in desired format
    hash[:title] = I18n.t('shared.chart_titles.reform.all_title')
    hash[:min] = data.first[:min]
    hash[:max] = data.first[:max]
    hash[:categories] = data.first[:categories]

    if options[:type] == 'stakeholder'
      hash[:type] = options[:type]
      hash[:subtitle] = I18n.t('shared.chart_titles.reform.subtitle_stakeholder')
    else # government
      hash[:type] = 'government'
      hash[:subtitle] = I18n.t('shared.chart_titles.reform.subtitle_government')
    end

    data.each do |reform|
      hash[:series] << {
        name: reform[:reform],
        color: reform[:color][:hex],
        data: reform[:series].map{|x| x[:data]}.flatten
      }
    end

    return hash

  end

  # get the reform survey data for all quarters
  # formatted in hash/json format
  # format: {type, reform, title, subtitle, color, min, max, categories: [x-axis labels], series: [{name: 'name', data: [ {y, change} ] } ] }
  # options:
  # - type: indicate if want government or stakeholder data (default government)
  # - overall_score_only - indicates whether just the overall score should be returned or overall and all category scores (default false)
  # - is_published - indicates if just the published quarters should be returned (default true)
  def self.reform_survey_data_for_charting(reform_id, options={})
    default_options = {type: 'government', overall_score_only: false, is_published: true, quarter_ids: nil}
    options = options.reverse_merge(default_options)

    hash = {
      type: nil,
      reform: nil,
      title: nil,
      subtitle: nil,
      color: {r: 0, g: 0, b: 0}, min: nil, max: nil, categories: [], series: []
    }
    quarters = oldest
    quarters = quarters.with_ids(options[:quarter_ids]) if options[:quarter_ids]
    quarters = quarters.published if options[:is_published]

    # get all of the survey results for this reform
    surveys = ReformSurvey.for_reform(reform_id)

    reform = Reform.active.find_by(id: reform_id)

    if quarters.present? && surveys.present? && reform.present?
      # make sure survey data is in correct quarter order
      temp = []
      quarters.each do |q|
        s = surveys.select{|x| x.quarter_id == q.id}.first
        if s.present?
          temp << s
        elsif options[:quarter_ids]
          temp << nil
        end
      end
      surveys = temp

      # set the reform name
      hash[:reform] = reform.name

      # set the title
      hash[:title] = I18n.t('shared.chart_titles.reform.title', name: reform.name)

      # load the x-axis labels (categories)
      hash[:categories] = quarters.map{|x| x.time_period}

      # get the reform color
      reform = Reform.find_by(id: reform_id)
      hash[:color] = reform.color.to_hash if reform
      hash[:id] = options[:id]

      # get the data
      if options[:type] == 'stakeholder'
        hash[:type] = options[:type]
        hash[:subtitle] = I18n.t('shared.chart_titles.reform.subtitle_stakeholder')
        hash[:min] = 0
        hash[:max] = 10

        # overall
        hash[:series] << {
          name: I18n.t('shared.categories.overall'),
          type: 'areaspline',
          data: surveys.map{|x| {y: x.nil? ? nil : x.stakeholder_overall_score.to_f, change: x.nil? ? nil : x.stakeholder_overall_change}}}
        if !options[:overall_score_only]
          # category 1
          hash[:series] << {
            name: I18n.t('shared.categories.performance'),
            dashStyle: 'longDash',
            data: surveys.map{|x| {y: x.nil? ? nil : x.stakeholder_category1_score.to_f, change: x.nil? ? nil : x.stakeholder_category1_change}}}
          # category 2
          hash[:series] << {
            name: I18n.t('shared.categories.goals'),
            dashStyle: 'shortDash',
            data: surveys.map{|x| {y: x.nil? ? nil : x.stakeholder_category2_score.to_f, change: x.nil? ? nil : x.stakeholder_category2_change}}}
          # category 3
          hash[:series] << {
            name: I18n.t('shared.categories.progress'),
            dashStyle: 'dot',
            data: surveys.map{|x| {y: x.nil? ? nil : x.stakeholder_category3_score.to_f, change: x.nil? ? nil : x.stakeholder_category3_change}}}
        end
      else #government
        hash[:type] = 'government'
        hash[:subtitle] = I18n.t('shared.chart_titles.reform.subtitle_government')
        hash[:min] = 0
        hash[:max] = 100

        # overall
        hash[:series] << {
          name: I18n.t('shared.categories.overall'),
          type: 'areaspline',
          data: surveys.map{|x| {y: x.nil? ? nil : x.government_overall_score.to_f, change: x.nil? ? nil : x.government_overall_change}}}

        if !options[:overall_score_only]
          # category 1
          hash[:series] << {
            name: I18n.t('shared.categories.initial_setup'),
            dashStyle: 'dot',
            data: surveys.map{|x| {y: x.nil? ? nil : x.government_category1_score.to_f, change: x.nil? ? nil : x.government_category1_change}}}
          # category 2
          hash[:series] << {
            name: I18n.t('shared.categories.capacity_building'),
            dashStyle: 'shortDash',
            data: surveys.map{|x| {y: x.nil? ? nil : x.government_category2_score.to_f, change: x.nil? ? nil : x.government_category2_change}}}
          # category 3
          hash[:series] << {
            name: I18n.t('shared.categories.infastructure_budgeting'),
            dashStyle: 'longDash',
            data: surveys.map{|x| {y: x.nil? ? nil : x.government_category3_score.to_f, change: x.nil? ? nil : x.government_category3_change}}}
          # category 4
          hash[:series] << {
            name: I18n.t('shared.categories.legislation_regulation'),
            dashStyle: 'LongDashDotDot',
            data: surveys.map{|x| {y: x.nil? ? nil : x.government_category4_score.to_f, change: x.nil? ? nil : x.government_category4_change}}}
        end

        # Specify that unit is '%' for government data
        hash[:series].each do |series|
          series[:data].each { |data| data[:unit] = '%' }
        end
      end
    end

    return hash
  end

  #######################
  ## METHODS

  # formal name of quarter: Q# 2016
  def time_period
    "Q#{self.quarter} #{self.year}"
  end


  def set_reform(reform_slug)
    reform = Reform.friendly.find(reform_slug)
    if reform
      reform_id = reform.id
    end
  end

end
