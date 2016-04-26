# == Schema Information
#
# Table name: quarters
#
#  id         :integer          not null, primary key
#  quarter    :integer          not null
#  year       :integer          not null
#  is_public  :boolean          default(FALSE)
#  slug       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Quarter < ActiveRecord::Base
  #######################
  ## TRANSLATIONS

  translates :summary_good, :summary_bad, :fallbacks_for_empty_translations => true
  globalize_accessors

  #######################
  ## RELATIONSHIPS
  has_one :expert_survey, dependent: :destroy
  has_many :reform_surveys, dependent: :destroy

  #######################
  ## VALIDATIONS

  validates :quarter, :year, :slug, presence: :true
  validates_uniqueness_of :year, scope: :quarter
  validates_uniqueness_of :slug

  #######################
  ## SLUG DEFINITION (friendly_id)

  extend FriendlyId
  friendly_id :slug_candidates, use: [:slugged, :history]

  # the slug should be: year-quarter
  def slug_candidates
    [
      [:year, :quarter]
    ]
  end

  # for genereate friendly_id
  def should_generate_new_friendly_id?
    quarter_changed? || year_changed? || super
  end

  # for locale sensitive transliteration with friendly_id
  def normalize_friendly_id(input)
    input.to_s.to_slug.normalize.to_s
  end

  #######################
  ## SCOPES
  scope :published, -> { where(is_public: true) }
  scope :recent, -> {order(slug: :desc)}

end
