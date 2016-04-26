# == Schema Information
#
# Table name: reform_surveys
#
#  id                          :integer          not null, primary key
#  quarter_id                  :integer          not null
#  reform_id                   :integer          not null
#  government_overall_score    :decimal(5, 2)    not null
#  government_category1_score  :decimal(5, 2)    not null
#  government_category2_score  :decimal(5, 2)    not null
#  government_category3_score  :decimal(5, 2)    not null
#  government_category4_score  :decimal(5, 2)    not null
#  stakeholder_overall_score   :decimal(5, 2)    not null
#  stakeholder_category1_score :decimal(5, 2)    not null
#  stakeholder_category2_score :decimal(5, 2)    not null
#  stakeholder_category3_score :decimal(5, 2)    not null
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
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

end
