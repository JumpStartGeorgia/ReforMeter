# == Schema Information
#
# Table name: expert_surveys
#
#  id               :integer          not null, primary key
#  quarter_id       :integer          not null
#  overall_score    :decimal(5, 2)    not null
#  category1_score  :decimal(5, 2)    not null
#  category2_score  :decimal(5, 2)    not null
#  category3_score  :decimal(5, 2)    not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  overall_change   :integer
#  category1_change :integer
#  category2_change :integer
#  category3_change :integer
#

class ExpertSurvey < ActiveRecord::Base
  #######################
  ## TRANSLATIONS

  translates :summary, :details, :fallbacks_for_empty_translations => true
  globalize_accessors

  #######################
  ## RELATIONSHIPS

  belongs_to :quarter
  has_and_belongs_to_many :experts
  accepts_nested_attributes_for :experts, reject_if: :all_blank

  #######################
  ## VALIDATIONS

  validates :quarter_id, :overall_score, :category1_score, :category2_score, :category3_score, presence: :true

  validates :overall_score, :category1_score, :category2_score, :category3_score, inclusion: {in: 0.0..10.0}
  validates :overall_change, :category1_change, :category2_change, :category3_change, inclusion: {in: [-1, 0, 1]}
  validates_uniqueness_of :quarter_id

  #######################
  ## CALLBACKS

  before_save :set_change_values
  after_save :update_future_quarter
  after_destroy :reset_future_quarter

  # set the change value when compared to the last quarter
  def set_change_values
    # get the previous quarter
    prev_q = Quarter.quarter_before(self.quarter_id)
    prev_es = ExpertSurvey.in_quarter(prev_q.id) if prev_q.present?
    compute_change_values(self, prev_es)

    return true
  end

  # if the next quarter has a survey for this reform
  # calculate its change values
  def update_future_quarter
    # get the next quarter
    next_q = Quarter.quarter_after(self.quarter_id)
    next_es = ExpertSurvey.in_quarter(next_q.id) if next_q.present?
    if next_es.present?
      update_change_value(next_es, self)
      next_es.save
    end

    return true
  end

  # if the next quarter has a survey for this reform
  # reset its change values
  def reset_future_quarter
    # get the next quarter
    next_q = Quarter.quarter_after(self.quarter_id)
    next_es = ExpertSurvey.in_quarter(next_q.id) if next_q.present?
    if next_es.present?
      reset_change_value(next_es)
      next_es.save
    end

    return true
  end

  #######################
  ## SCOPES

  # get the survey for the provided quarter id
  def self.in_quarter(quarter_id)
    where(quarter_id: quarter_id).first
  end


  #######################
  #######################
  private

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
