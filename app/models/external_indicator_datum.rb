# == Schema Information
#
# Table name: external_indicator_data
#
#  id                         :integer          not null, primary key
#  external_indicator_time_id :integer
#  country_id                 :integer
#  index_id                   :integer
#  value                      :decimal(5, 2)    not null
#  change                     :integer
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  is_benchmark               :boolean          default(FALSE)
#

class ExternalIndicatorDatum < ActiveRecord::Base

  #######################
  ## RELATIONSHIPS
  belongs_to :external_indicator_time

  #######################
  ## VALIDATIONS
  validates :value, presence: :true

end
