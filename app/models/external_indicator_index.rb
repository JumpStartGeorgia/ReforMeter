# == Schema Information
#
# Table name: external_indicator_indices
#
#  id                    :integer          not null, primary key
#  external_indicator_id :integer
#  change_multiplier     :integer          default(1)
#  sort_order            :integer          default(1)
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

class ExternalIndicatorIndex < ActiveRecord::Base
  #######################
  ## TRANSLATIONS

  translates :name, :short_name, :description, :fallbacks_for_empty_translations => true
  globalize_accessors

  #######################
  ## RELATIONSHIPS
  belongs_to :external_indicator

  #######################
  ## VALIDATIONS

  validates :name, :short_name, :sort_order, presence: :true
  validates :change_multiplier, inclusion: {in: [-1, 1]}


end
