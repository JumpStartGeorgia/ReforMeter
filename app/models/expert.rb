# == Schema Information
#
# Table name: experts
#
#  id         :integer          not null, primary key
#  is_active  :boolean          default(TRUE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Expert < ActiveRecord::Base
  #######################
  ## TRANSLATIONS

  translates :name, :bio, :fallbacks_for_empty_translations => true
  globalize_accessors

  #######################
  ## RELATIONSHIPS
  has_and_belongs_to_many :expert_surveys

  #######################
  ## VALIDATIONS

  validates :name, presence: :true

end
