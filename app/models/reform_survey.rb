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

  #######################
  ## SCOPES

  def self.for_reform(reform_id)
    where(reform_id: reform_id)
  end

  # get all surveys that are in the provided quarter id
  def self.in_quarter(quarter_id)
    in_quarters(quarter_id)
  end

  # get all surveys that are in the provided list of quarter ids
  def self.in_quarters(quarter_ids)
    where(quarter_id: quarter_ids).order(:quarter_id, :reform_id)
  end


  #######################
  ## METHODS

  # compute the chagne value for government scores
  # scores are percents
  # < 0 -> -1
  # == 0 -> 0
  # > 0 -> 1
  def compute_government_change(previous_score, new_score)
    difference = new_score - previous_score
    return difference < 0 ? -1 : difference > 0 ? 1 : 0
  end

  # compute the chagne value for government scores
  # scores are numbers from 0 to 10
  # < -0.2 -> -1
  # -0.2 .. 0.2 -> 0
  # > 0.2 -> 1
  def compute_stakeholder_change(previous_score, new_score)
    difference = new_score - previous_score
    return difference < -0.2 ? -1 : difference > 0.2 ? 1 : 0
  end
end
