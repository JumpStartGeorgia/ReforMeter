# == Schema Information
#
# Table name: external_indicator_plot_bands
#
#  id                    :integer          not null, primary key
#  external_indicator_id :integer
#  from                  :integer
#  to                    :integer
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

class ExternalIndicatorPlotBand < ActiveRecord::Base
  #######################
  ## TRANSLATIONS

  translates :name, :fallbacks_for_empty_translations => true
  globalize_accessors

  #######################
  ## RELATIONSHIPS
  belongs_to :external_indicator

  #######################
  ## VALIDATIONS
  validates :name, :from, :to, presence: :true
  validates_numericality_of :from
  validates_numericality_of :to, greater_than: :from


  #######################
  ## SCOPES
  scope :sorted, -> { order(from: :asc) }
end
