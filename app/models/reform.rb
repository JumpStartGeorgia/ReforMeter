# == Schema Information
#
# Table name: reforms
#
#  id           :integer          not null, primary key
#  is_active    :boolean          default(TRUE)
#  is_highlight :boolean          default(TRUE)
#  slug         :string(255)      not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Reform < ActiveRecord::Base
  #######################
  ## TRANSLATIONS

  translates :name, :summary, :methodology, :fallbacks_for_empty_translations => true
  globalize_accessors

  #######################
  ## RELATIONSHIPS
  has_many :reform_surveys, dependent: :destroy

  #######################
  ## VALIDATIONS

  validates :name, :summary, :slug, presence: :true
  validates_uniqueness_of :name
  validates_uniqueness_of :slug

  #######################
  ## SLUG DEFINITION (friendly_id)

  extend FriendlyId
  friendly_id :name, use: [:slugged, :history]

  # for genereate friendly_id
  def should_generate_new_friendly_id?
    name? || super
  end

  # for locale sensitive transliteration with friendly_id
  def normalize_friendly_id(input)
    input.to_s.to_slug.normalize.to_s
  end

  #######################
  ## SCOPES
  scope :active, -> { where(is_active: true) }
  scope :highlight, -> { where(is_highlight: true) }

end
