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

end
