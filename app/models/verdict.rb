# == Schema Information
#
# Table name: verdicts
#
#  id               :integer          not null, primary key
#  overall_score    :decimal(5, 2)    not null
#  category1_score  :decimal(5, 2)    not null
#  category2_score  :decimal(5, 1)    not null
#  category3_score  :decimal(5, 2)    not null
#  overall_change   :integer
#  integer          :integer
#  category1_change :integer
#  category2_change :integer
#  category3_change :integer
#  is_public        :boolean          default(FALSE)
#  slug             :string(255)
#  time_period      :date
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Verdict < ActiveRecord::Base

  #######################
  ## TRANSLATIONS

  translates :title, :summary, :slug, :fallbacks_for_empty_translations => true
  globalize_accessors

  #######################
  ## RELATIONSHIPS
  has_many :news, -> { where(reform_survey_id: nil) }, dependent: :destroy
  has_many :reform_surveys
  has_many :reforms, through: :reform_surveys

  #######################
  ## VALIDATIONS

  validates :title, :time_period, presence: :true
  validates_uniqueness_of :title
  validates :overall_score, inclusion: {in: 0.0..10.0}, if: "!overall_score.nil?"
  validates :category1_score, inclusion: {in: 0.0..10.0}, if: "!category1_score.nil?"
  validates :category2_score, inclusion: {in: 0.0..10.0}, if: "!category2_score.nil?"
  validates :category3_score, inclusion: {in: 0.0..10.0}, if: "!category3_score.nil?"

  #######################
  ## SLUG DEFINITION (friendly_id)

  extend FriendlyId
  friendly_id :title, use: [:globalize, :history, :slugged]

  # for genereate friendly_id
  def should_generate_new_friendly_id?
#    name_changed? || super
    super
  end

  # for locale sensitive transliteration with friendly_id
  def normalize_friendly_id(input)
    input.to_s.to_url
  end

  #######################
  ## CALLBACKS

  before_save :check_publish_fields
  before_save :set_change_values
  after_save :update_future_survey
  after_destroy :reset_future_survey

  #######################
  ## SCOPES
  scope :published, -> { where(is_public: true) }
  scope :sorted, -> { order(time_period: :asc) }
  scope :recent, -> { order(time_period: :desc) }
  scope :with_reform_surveys, -> {includes(reform_surveys: [:translations] )}
  scope :with_news, -> {includes(news: [:translations] )}

  def self.next_survey(time_period)
    where('time_period > ?', time_period).sorted.first
  end

  def self.previous_survey(time_period)
    where('time_period < ?', time_period).recent.first
  end

  # get all verdicts with the provided ids
  def self.with_ids(verdict_ids)
    where(id: verdict_ids)
  end

  # get an array of the active verdicts in format: [title, slug]
  def self.active_verdicts_array
    published.recent.map{|x| [x.title, x.slug]}
  end

  # get an array of all verdicts in format: [title, slug]
  def self.all_verdicts_array
    recent.map{|x| [x.title, x.slug]}
  end

  # get all of the verdicts that this reform exists in
  def self.with_reform(reform_id)
    includes(:reform_surveys).where(reform_surveys: {reform_id: reform_id})
  end

  def self.linked_reforms
    sql = <<-QUERY
      select vt.slug AS verdict_slug, r.slug AS reform_slug
      from verdicts as v
      inner join verdict_translations as vt on vt.verdict_id = v.id
      inner join reform_surveys as rs on rs.verdict_id = v.id
      inner join reform_translations as r on r.reform_id = rs.reform_id and r.locale = ?
      where v.is_public=1 and rs.is_public=1
      order by vt.slug, r.slug
    QUERY

    find_by_sql([sql, I18n.locale])
  end



  # expert columns: quarter, year, time period, overall, cat1, cat2, cat3
  # reform columns: year, time period, govt overall, govt cat1, govt cat2, govt cat3, govt cat4, stakeholder cat1, stakeholder cat2, stakeholder cat3
  def self.to_csv(type='reform', reform_id=nil)
    if type == 'reform' && reform_id.present?
      # get all of the survey results for this reform
      surveys = ReformSurvey.for_reform(reform_id)

      header = %w{year time_period government_overall_score government_insitutional_setup_score government_capacity_building_score government_infastructure_budgeting_score government_legislation_regulations_score stakholder_overall_score stakholder_performance_score stakholder_goals_score stakholder_progress_score }

      CSV.generate do |csv|
        csv << header

        published.recent.each do |v|
          survey = surveys.select{|x| x.verdict_id == v.id}.first
          if survey
            csv << [
                    v.time_period.year, v.title,
                    survey.government_overall_score, survey.government_category1_score, survey.government_category2_score, survey.government_category3_score, survey.government_category4_score,
                    survey.stakeholder_overall_score, survey.stakeholder_category1_score, survey.stakeholder_category2_score, survey.stakeholder_category3_score
                  ]
          end
        end
      end

    # else

    #   header = %w{quarter year time_period overall_score performance_score goals_score progress_score}
    #   CSV.generate do |csv|
    #     csv << header

    #     published.recent.with_expert_survey.each do |q|
    #       csv << [q.quarter, q.year, q.time_period, q.expert_survey.overall_score, q.expert_survey.category1_score, q.expert_survey.category2_score, q.expert_survey.category3_score]
    #     end
    #   end
    end
  end

  # get the survey data for all verdicts
  # formatted in hash/json format
  # format: {title, subtitle, min, max, categories: [x-axis labels], series: [{name: 'name', data: [ {y, change} ] } ] }
  # options:
  # - overall_score_only - indicates whether just the overall score should be returned or overall and all category scores (default false)
  # - is_published - indicates if just the published quarters should be returned (default true)
  def self.verdict_data_for_charting(options={})
    default_options = {overall_score_only: false, is_published: true}
    options = options.reverse_merge(default_options)

    hash = {
      title: I18n.t('shared.chart_titles.verdict.title'),
      id: options[:id],
      png_image_path: options[:png_image_path],
      subtitle: nil,
      min: 0,
      max: 10,
      categories: [],
      series: [],
      translations: {
        behind: I18n.t('shared.chart_rating_categories.reforms.behind'),
        on_track: I18n.t('shared.chart_rating_categories.reforms.on_track'),
        ahead: I18n.t('shared.chart_rating_categories.reforms.ahead')
      }
    }

    verdicts = sorted
    verdicts = verdicts.published if options[:is_published]

    if verdicts.present?
      # load the x-axis labels (categories)
      hash[:categories] = verdicts.map{|x| x.title}

      # get the data
      # overall
      hash[:series] << {
        name: I18n.t('shared.categories.overall'),
        type: 'areaspline',
        data: verdicts.map{|x| {y: x.overall_score.to_f, change: x.overall_change}}}

      if !options[:overall_score_only]
        # category 1
        hash[:series] << {
          name: I18n.t('shared.categories.performance'),
          dashStyle: 'longDash',
          data: verdicts.map{|x| {y: x.category1_score.to_f, change: x.category1_change}}
        }
        # category 2
        # hash[:series] << {
        #   name: I18n.t('shared.categories.goals'),
        #   dashStyle: 'shortDash',
        #   data: verdicts.map{|x| {y: x.category2_score.to_f, change: x.category2_change}}
        # }
        hash[:series] << {
          name: I18n.t('shared.categories.progress'),
          dashStyle: 'dot',
          data: verdicts.map{|x| {y: x.category2_score.to_f, change: x.category2_change}}
        }
        # category 3
        hash[:series] << {
          name: I18n.t('shared.categories.outcome'),
          dashStyle: 'shortDash',
          data: verdicts.map{|x| {y: x.category3_score.to_f, change: x.category3_change}}
        }
      end
    end

    return hash
  end




  # get the reform survey data for all verdicts for all reforms
  # formatted in hash/json format
  # format: {type, title, subtitle, min, max, categories: [x-axis labels], series: [{name: 'name', color: rgb(), data: [ {y, change} ] } ] }
  # options:
  # - type: indicate if want government or stakeholder data (default government)
  # - is_published - indicates if just the published verdicts should be returned (default true)
  def self.all_reform_survey_data_for_charting(options={})
    default_options = {type: 'government', is_published: true, overall_score_only: true, verdict_ids: nil}
    options = options.reverse_merge(default_options)

    hash = {
      type: nil,
      title: nil,
      id: options[:id],
      subtitle: nil,
      min: nil, max: nil, categories: [], series: [],
      unitLabel: I18n.t('shared.common.percent')
    }

    reforms = Reform.active.with_survey_data(options[:is_published])

    # get data for all reforms
    data = []
    if reforms.present?
      reforms.each do |reform|
        data << reform_survey_data_for_charting(reform.id, options)
      end
    end

    # put together in desired format
    hash[:title] = I18n.t('shared.chart_titles.reform.all_title')
    hash[:min] = data.first[:min] if data.present?
    hash[:max] = data.first[:max] if data.present?
    hash[:categories] = data.first[:categories] if data.present?

    if options[:type] == 'stakeholder'
      hash[:type] = options[:type]
      hash[:subtitle] = I18n.t('shared.chart_titles.reform.subtitle_stakeholder')
      hash[:translations] = {
        behind: I18n.t('shared.chart_rating_categories.reforms.behind'),
        on_track: I18n.t('shared.chart_rating_categories.reforms.on_track'),
        ahead: I18n.t('shared.chart_rating_categories.reforms.ahead')
      }
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

  # get the reform survey data for all verdicts
  # formatted in hash/json format
  # format: {type, reform, title, subtitle, color, min, max, categories: [x-axis labels], series: [{name: 'name', data: [ {y, change} ] } ] }
  # options:
  # - type: indicate if want government or stakeholder data (default government)
  # - overall_score_only - indicates whether just the overall score should be returned or overall and all category scores (default false)
  # - is_published - indicates if just the published verdicts should be returned (default true)
  def self.reform_survey_data_for_charting(reform_id, options={})
    default_options = {type: 'government', overall_score_only: false, is_published: true, verdict_ids: nil}
    options = options.reverse_merge(default_options)

    hash = {
      type: nil,
      reform: nil,
      title: nil,
      subtitle: nil,
      color: {r: 0, g: 0, b: 0}, min: nil, max: nil, categories: [], series: []
    }

    verdicts = sorted
    verdicts = verdicts.with_ids(options[:verdict_ids]) if options[:verdict_ids]
    verdicts = verdicts.published if options[:is_published]

    # get all of the survey results for this reform
    surveys = ReformSurvey.for_reform(reform_id)

    reform = Reform.active.with_survey_data(options[:is_published]).find_by(id: reform_id)

    if verdicts.present? && surveys.present? && reform.present?
      # make sure survey data is in correct verdict order
      temp = []
      verdicts.each do |v|
        s = options[:is_published] == true ? surveys.select{|x| x.verdict_id == v.id && x.is_public?}.first : surveys.select{|x| x.verdict_id == v.id}.first
        if s.present?
          temp << s
        elsif options[:verdict_ids]
          temp << nil
        end
      end
      surveys = temp

      # set the reform name
      hash[:reform] = reform.name

      # set the title
      hash[:title] = I18n.t('shared.chart_titles.reform.title', name: reform.name)

      # load the x-axis labels (categories)
      hash[:categories] = verdicts.map{|x| x.title}

      # get the reform color
      hash[:color] = reform.color.to_hash if reform
      hash[:id] = options[:id]

      # get the data
      if options[:type] == 'stakeholder'
        hash[:type] = options[:type]
        hash[:subtitle] = I18n.t('shared.chart_titles.reform.subtitle_stakeholder')
        hash[:min] = 0
        hash[:max] = 10
        hash[:translations] = {
          behind: I18n.t('shared.chart_rating_categories.reforms.behind'),
          on_track: I18n.t('shared.chart_rating_categories.reforms.on_track'),
          ahead: I18n.t('shared.chart_rating_categories.reforms.ahead')
        }

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
          # hash[:series] << {
          #   name: I18n.t('shared.categories.goals'),
          #   dashStyle: 'shortDash',
          #   data: surveys.map{|x| {y: x.nil? ? nil : x.stakeholder_category2_score.to_f, change: x.nil? ? nil : x.stakeholder_category2_change}}}
          hash[:series] << {
            name: I18n.t('shared.categories.progress'),
            dashStyle: 'shortDash',
            data: surveys.map{|x| {y: x.nil? ? nil : x.stakeholder_category2_score.to_f, change: x.nil? ? nil : x.stakeholder_category2_change}}}
          # category 3
          hash[:series] << {
            name: I18n.t('shared.categories.outcome'),
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
            dashStyle: 'Dot',
            data: surveys.map{|x| {y: x.nil? ? nil : x.government_category1_score.to_f, change: x.nil? ? nil : x.government_category1_change}}}
          # category 2
          hash[:series] << {
            name: I18n.t('shared.categories.capacity_building'),
            dashStyle: 'ShortDash',
            data: surveys.map{|x| {y: x.nil? ? nil : x.government_category2_score.to_f, change: x.nil? ? nil : x.government_category2_change}}}
          # category 3
          hash[:series] << {
            name: I18n.t('shared.categories.infastructure_budgeting'),
            dashStyle: 'Dash',
            data: surveys.map{|x| {y: x.nil? ? nil : x.government_category3_score.to_f, change: x.nil? ? nil : x.government_category3_change}}}
          # category 4
          hash[:series] << {
            name: I18n.t('shared.categories.legislation_regulation'),
            dashStyle: 'LongDash',
            data: surveys.map{|x| {y: x.nil? ? nil : x.government_category4_score.to_f, change: x.nil? ? nil : x.government_category4_change}}}
        end

        # Specify that unit is '%' for government data
        hash[:series].each do |series|
          series[:data].each_with_index do |data, index|
            data[:unit] = '%'
            data[:verdict_name] = hash[:categories][index]
          end
        end
      end
    end

    return hash
  end
  #######################
  ## METHODS

  # get an array of the reform ids in this verdict
  def reform_ids
    reform_surveys.pluck(:reform_id)
  end

  # formatted time period (month/year only)
  def time_period_formatted
    I18n.l(self.time_period, format: :time_period)
  end


  #######################
  #######################
  private

  # if this verdict is published, make sure the scores are present
  def check_publish_fields
    if self.is_public?
      if self.overall_score.nil?
        errors.add :overall_score, I18n.t('shared.msgs.scores_required')
      end
      if self.category1_score.nil?
        errors.add :category1_score, I18n.t('shared.msgs.scores_required')
      end
      if self.category2_score.nil?
        errors.add :category2_score, I18n.t('shared.msgs.scores_required')
      end
      if self.category3_score.nil?
        errors.add :category3_score, I18n.t('shared.msgs.scores_required')
      end
    end

    return true
  end

  # set the change value when compared to the last survey
  def set_change_values
    # get the previous survey
    prev_verdict = Verdict.previous_survey(self.time_period)
    compute_change_values(self, prev_verdict)

    return true
  end

  # if there is a time period after this one, 
  # calculate its change values
  def update_future_survey
    # get the next survey
    next_verdict = Verdict.next_survey(self.time_period)
    if next_verdict.present?
      update_change_value(next_verdict, self)
      next_verdict.save
    end

    return true
  end

  # if there is a time period after this one, 
  # reset its change values
  def reset_future_survey
    # get the next survey
    next_verdict = Verdict.next_survey(self.time_period)
    if next_verdict.present?
      reset_change_value(next_verdict)
      next_verdict.save
    end

    return true
  end

  def compute_change_values(current_survey, previous_survey)
    if current_survey.present? && previous_survey.present?
      # found survey, so compute change
      update_change_value(current_survey, previous_survey)
    else
      # previous verdict does not exist or survey does not exist,
      # so cannot compute change values
      # so all changes values must be null
      reset_change_value(current_survey)
    end

  end

  def update_change_value(current_survey, previous_survey)
    current_survey.overall_change = compute_change(current_survey.overall_score, previous_survey.overall_score)
    current_survey.category1_change = compute_change(current_survey.category1_score, previous_survey.category1_score)
    current_survey.category2_change = compute_change(current_survey.category2_score, previous_survey.category2_score)
    current_survey.category3_change = compute_change(current_survey.category3_score, previous_survey.category3_score)
  end

  def reset_change_value(current_survey)
    current_survey.overall_change = nil
    current_survey.category1_change = nil
    current_survey.category2_change = nil
    current_survey.category3_change = nil
  end

  # stakeholder is 0-10 and difference of at least 0,2 must be had to be record as changed
  def compute_change(current_value, previous_value)
    change = nil
    if current_value.present? && previous_value.present?
      diff = current_value - previous_value
      if diff < -0.2
        change = -1
      elsif diff > 0.2
        change = 1
      else
        change = 0
      end
    end
    
    return change
  end

end
