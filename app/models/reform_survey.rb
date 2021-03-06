# == Schema Information
#
# Table name: reform_surveys
#
#  id                           :integer          not null, primary key
#  quarter_id                   :integer          not null
#  reform_id                    :integer          not null
#  government_overall_score     :decimal(5, 2)    not null
#  government_category1_score   :decimal(5, 2)    not null
#  government_category2_score   :decimal(5, 2)    not null
#  government_category3_score   :decimal(5, 2)    not null
#  government_category4_score   :decimal(5, 2)    not null
#  stakeholder_overall_score    :decimal(5, 2)    not null
#  stakeholder_category1_score  :decimal(5, 2)    not null
#  stakeholder_category2_score  :decimal(5, 2)    not null
#  stakeholder_category3_score  :decimal(5, 2)    not null
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#  government_overall_change    :integer
#  government_category1_change  :integer
#  government_category2_change  :integer
#  government_category3_change  :integer
#  government_category4_change  :integer
#  stakeholder_overall_change   :integer
#  stakeholder_category1_change :integer
#  stakeholder_category2_change :integer
#  stakeholder_category3_change :integer
#

class ReformSurvey < ActiveRecord::Base
  #######################
  ## TRANSLATIONS

  translates :summary, :government_summary, :stakeholder_summary, :fallbacks_for_empty_translations => true
  globalize_accessors

  #######################
  ## RELATIONSHIPS

  belongs_to :quarter
  belongs_to :reform

  #######################
  ## VALIDATIONS

  validates :quarter_id, :reform_id,
            :government_overall_score, :government_category1_score, :government_category2_score, :government_category3_score, :government_category4_score,
            :stakeholder_overall_score, :stakeholder_category1_score, :stakeholder_category2_score, :stakeholder_category3_score,
            presence: :true

  validates :government_overall_score, :government_category1_score, :government_category2_score, :government_category3_score, :government_category4_score, inclusion: {in: 0.0..100.0}
  validates :stakeholder_overall_score, :stakeholder_category1_score, :stakeholder_category2_score, :stakeholder_category3_score, inclusion: {in: 0.0..10.0}
  # validates :government_overall_change, :government_category1_change, :government_category2_change, :government_category3_change, :government_category4_change,
  #             :stakeholder_overall_change, :stakeholder_category1_change, :stakeholder_category2_change, :stakeholder_category3_change, inclusion: {in: [-1, 0, 1]}
  validates_uniqueness_of :reform_id, scope: :quarter_id

  #######################
  ## CALLBACKS

  before_save :set_change_values
  after_save :update_future_quarter
  after_destroy :reset_future_quarter

  #######################
  ## SCOPES

  def self.for_reform(reform_id)
    where(reform_id: reform_id)
  end

  def self.not_in_reform(reform_id)
    where.not(reform_id: reform_id)
  end

  # get all surveys that are in the provided quarter id
  def self.in_quarter(quarter_id)
    in_quarters(quarter_id)
  end

  # get all surveys that are in the provided list of quarter ids
  def self.in_quarters(quarter_ids)
    where(quarter_id: quarter_ids).order(:quarter_id, :reform_id)
  end


  # get the overall score and change for a quarter, reform and type (government or stakeholder)
  # format: {reform_id, score, change}
  def self.overall_values_only(quarter_id, reform_id, type='government')
    value = where(quarter_id: quarter_id, reform_id: reform_id)
    if type == 'stakeholder'
      value = value.select(:stakeholder_overall_score, :stakeholder_overall_change).first
      return {reform_id: reform_id, score: value.stakeholder_overall_score.to_f, change: value.stakeholder_overall_change} if value.present?
    else # government
      value = value.select(:government_overall_score, :government_overall_change).first
      return {reform_id: reform_id, score: value.government_overall_score.to_f, change: value.government_overall_change} if value.present?
    end
    return []
  end

  #######################
  ## METHODS

  # # compute the chagne value for government scores
  # # scores are percents
  # # < 0 -> -1
  # # == 0 -> 0
  # # > 0 -> 1
  # def compute_government_change(previous_score, new_score)
  #   difference = new_score - previous_score
  #   return difference < 0 ? -1 : difference > 0 ? 1 : 0
  # end

  # # compute the chagne value for government scores
  # # scores are numbers from 0 to 10
  # # < -0.2 -> -1
  # # -0.2 .. 0.2 -> 0
  # # > 0.2 -> 1
  # def compute_stakeholder_change(previous_score, new_score)
  #   difference = new_score - previous_score
  #   return difference < -0.2 ? -1 : difference > 0.2 ? 1 : 0
  # end


  #######################
  #######################
  private

  # set the change value when compared to the last quarter
  def set_change_values
    # get the previous quarter
    prev_q = Quarter.quarter_before(self.quarter_id)
    prev_rs = ReformSurvey.for_reform(self.reform_id).in_quarter(prev_q.id).first if prev_q.present?
    compute_change_values(self, prev_rs)

    return true
  end

  # if the next quarter has a survey for this reform
  # calculate its change values
  def update_future_quarter
    # get the next quarter
    next_q = Quarter.quarter_after(self.quarter_id)
    next_rs = ReformSurvey.for_reform(self.reform_id).in_quarter(next_q.id).first if next_q.present?
    if next_rs.present?
      update_change_value(next_rs, self)
      next_rs.save
    end

    return true
  end

  # if the next quarter has a survey for this reform
  # reset its change values
  def reset_future_quarter
    # get the next quarter
    next_q = Quarter.quarter_after(self.quarter_id)
    next_rs = ReformSurvey.for_reform(self.reform_id).in_quarter(next_q.id).first if next_q.present?
    if next_rs.present?
      reset_change_value(next_rs)
      next_rs.save
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
    current_survey.government_overall_change = compute_government_change(current_survey.government_overall_score, previous_survey.government_overall_score)
    current_survey.government_category1_change = compute_government_change(current_survey.government_category1_score, previous_survey.government_category1_score)
    current_survey.government_category2_change = compute_government_change(current_survey.government_category2_score, previous_survey.government_category2_score)
    current_survey.government_category3_change = compute_government_change(current_survey.government_category3_score, previous_survey.government_category3_score)
    current_survey.government_category4_change = compute_government_change(current_survey.government_category4_score, previous_survey.government_category4_score)
    current_survey.stakeholder_overall_change = compute_stakeholder_change(current_survey.stakeholder_overall_score, previous_survey.stakeholder_overall_score)
    current_survey.stakeholder_category1_change = compute_stakeholder_change(current_survey.stakeholder_category1_score, previous_survey.stakeholder_category1_score)
    current_survey.stakeholder_category2_change = compute_stakeholder_change(current_survey.stakeholder_category2_score, previous_survey.stakeholder_category2_score)
    current_survey.stakeholder_category3_change = compute_stakeholder_change(current_survey.stakeholder_category3_score, previous_survey.stakeholder_category3_score)
  end

  def reset_change_value(current_survey)
    current_survey.government_overall_change = nil
    current_survey.government_category1_change = nil
    current_survey.government_category2_change = nil
    current_survey.government_category3_change = nil
    current_survey.government_category4_change = nil
    current_survey.stakeholder_overall_change = nil
    current_survey.stakeholder_category1_change = nil
    current_survey.stakeholder_category2_change = nil
    current_survey.stakeholder_category3_change = nil
  end

  # government is % and any change in value is a change
  def compute_government_change(current_value, previous_value)
    diff = current_value - previous_value
    change = nil
    if diff < 0
      change = -1
    elsif diff > 0
      change = 1
    else
      change = 0
    end

    return change
  end

  # stakeholder is 0-10 and difference of at least 0.2 must be had to be record as changed
  def compute_stakeholder_change(current_value, previous_value)
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
