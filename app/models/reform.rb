# == Schema Information
#
# Table name: reforms
#
#  id              :integer          not null, primary key
#  is_active       :boolean          default(TRUE)
#  is_highlight    :boolean          default(TRUE)
#  slug            :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  reform_color_id :integer
#

class Reform < AddMissingTranslation
  #######################
  ## TRANSLATIONS

  translates :name, :summary, :methodology, :slug, :fallbacks_for_empty_translations => true
  globalize_accessors

  #######################
  ## RELATIONSHIPS
  has_many :reform_surveys, dependent: :destroy
  belongs_to :color, foreign_key: 'reform_color_id', class_name: 'ReformColor'
  has_many :news, dependent: :destroy
  has_and_belongs_to_many :external_indicators

  #######################
  ## VALIDATIONS

  validates :name, :summary, :reform_color_id, presence: :true
  validates_uniqueness_of :name

  #######################
  ## SLUG DEFINITION (friendly_id)

  extend FriendlyId
  friendly_id :name, use: [:globalize, :history, :slugged]

  # for genereate friendly_id
  def should_generate_new_friendly_id?
#    name_changed? || super
    super
  end

  # for locale sensitive transliteration with friendly_id
  def normalize_friendly_id(input)
    input.to_s.to_url
  end

  #######################
  ## SCOPES
  scope :active, -> { where(is_active: true) }
  scope :highlight, -> { where(is_highlight: true) }
  scope :sorted, -> { with_translations(I18n.locale).order(:name) }
  scope :with_color, -> {includes(:color )}

  # get an array of the active reforms in format: [name, slug]
  def self.active_reforms_array
    active.sorted.map{|x| [x.name, x.slug]}
  end

  # get all reforms that are in the verdict
  def self.in_verdict(verdict_id)
    v = Verdict.find_by(id: verdict_id)

    if v.present?
      where(id: v.reform_ids)
    end
  end

  def self.with_reform_survey (verdict_id, is_public=true)
    includes(:reform_surveys).where(reform_surveys: { verdict_id: verdict_id, is_public: is_public })
  end

  # get all reforms that have survey data
  def self.with_survey_data(verdicts_are_published=true)
    v = Verdict.all
    v = v.published if verdicts_are_published
    where(id: v.map{|x| x.reform_ids}.flatten.uniq)
  end



  #######################
  #######################
  private

  def has_required_translations?(trans)
    trans.name.present? && trans.summary.present?
  end

  def add_missing_translations(default_trans)
    self.name = default_trans.name if self["name_#{Globalize.locale}"].blank?
    self.summary = default_trans.summary if self["summary_#{Globalize.locale}"].blank?
  end
end
