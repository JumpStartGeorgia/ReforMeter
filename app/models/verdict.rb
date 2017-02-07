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
#  categoey2_change :integer
#  category2_change :integer
#  is_public        :boolean          default(FALSE)
#  slug             :string(255)
#  time_period      :date
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Verdict < ActiveRecord::Base

  #######################
  ## TRANSLATIONS

  translates :title, :slug, :fallbacks_for_empty_translations => true
  globalize_accessors

  #######################
  ## RELATIONSHIPS
  has_many :news, dependent: :destroy
  has_many :reform_surveys

  #######################
  ## VALIDATIONS

  validates :title, :overall_score, :category1_score, :category2_score, :category3_score, presence: :true
  validates_uniqueness_of :title
  validates :overall_score, :category1_score, :category2_score, :category3_score, inclusion: {in: 0.0..10.0}

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
  ## SCOPES
  scope :published, -> { where(is_public: true) }
  scope :sorted, -> { order(time_period: :asc) }
  scope :recent, -> { order(time_period: :desc) }

  def self.next_survey(time_period)
    where('time_period > ?', time_period).sorted.first
  end

  def self.previous_survey(time_period)
    where('time_period < ?', time_period).recent.first
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

  #######################
  ## CALLBACKS

  before_save :set_change_values
  after_save :update_future_survey
  after_destroy :reset_future_survey

  #######################
  ## METHODS

  # get an array of the reform ids in this verdict
  def reform_ids
    reform_surveys.pluck(:reform_id)
  end



  #######################
  #######################
  private

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
      # previous quarter does not exist or survey does not exist,
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
    diff = current_value - previous_value
    change = nil
    if diff < -0.2
      change = -1
    elsif diff > 0.2
      change = 1
    else
      change = 0
    end

    return change
  end

end
