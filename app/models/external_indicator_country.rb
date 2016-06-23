# == Schema Information
#
# Table name: external_indicator_countries
#
#  id                    :integer          not null, primary key
#  external_indicator_id :integer
#  sort_order            :integer          default(1)
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

class ExternalIndicatorCountry < ActiveRecord::Base
  #######################
  ## TRANSLATIONS

  translates :name, :sort_order, :fallbacks_for_empty_translations => true
  globalize_accessors

  #######################
  ## RELATIONSHIPS
  belongs_to :external_indicator

  #######################
  ## VALIDATIONS

  validates :name, presence: :true

end
