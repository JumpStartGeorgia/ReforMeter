# == Schema Information
#
# Table name: expert_surveys
#
#  id              :integer          not null, primary key
#  quarter_id      :integer          not null
#  overall_score   :decimal(5, 2)    not null
#  category1_score :decimal(5, 2)    not null
#  category2_score :decimal(5, 2)    not null
#  category3_score :decimal(5, 2)    not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
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

  #######################
  ## VALIDATIONS

  validates :quarter_id, :overall_score, :category1_score, :category2_score, :category3_score, presence: :true

end
