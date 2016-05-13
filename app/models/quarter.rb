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

class Quarter < ActiveRecord::Base
  #######################
  ## TRANSLATIONS

  translates :summary_good, :summary_bad, :fallbacks_for_empty_translations => true
  globalize_accessors

  #######################
  ## RELATIONSHIPS
  has_one :expert_survey, dependent: :destroy
  has_many :reform_surveys, dependent: :destroy

  accepts_nested_attributes_for :expert_survey, reject_if: :all_blank
  accepts_nested_attributes_for :reform_surveys, reject_if: :all_blank
  
  #######################
  ## VALIDATIONS

  validates :quarter, :year, :slug, presence: :true
  validates_uniqueness_of :year, scope: :quarter
  validates_uniqueness_of :slug
  validates_inclusion_of :quarter, in: 1..4
  validates_inclusion_of :year, in: 2015..2115

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
  scope :recent, -> {order(slug: :desc)}
  scope :with_expert_survey, -> {includes(expert_survey: [:translations] )}

  # get an array of the active quarters in format: [time period, slug]
  def self.active_quarters_array
    published.recent.map{|x| [x.time_period, x.slug]}
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

        published.recent.with_expert_survey.each do |q|
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
end
