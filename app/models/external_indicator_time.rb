# == Schema Information
#
# Table name: external_indicator_times
#
#  id                    :integer          not null, primary key
#  external_indicator_id :integer
#  sort_order            :integer          default(1)
#  overall_value         :decimal(5, 2)
#  overall_change        :integer
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

class ExternalIndicatorTime < ActiveRecord::Base
  #######################
  ## TRANSLATIONS

  translates :name, :fallbacks_for_empty_translations => true
  globalize_accessors

  #######################
  ## RELATIONSHIPS
  belongs_to :external_indicator
  has_many :data, class_name: 'ExternalIndicatorDatum', dependent: :destroy
  accepts_nested_attributes_for :data, :reject_if => lambda { |x| x[:value].blank?}, allow_destroy: true

  #######################
  ## VALIDATIONS
  validates :name, :sort_order, presence: :true

  #######################
  ## SCOPES
  scope :sorted, -> { order(sort_order: :asc) }


end
