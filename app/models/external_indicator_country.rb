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

class ExternalIndicatorCountry < AddMissingTranslation
  #######################
  ## TRANSLATIONS

  translates :name, :fallbacks_for_empty_translations => true
  globalize_accessors

  #######################
  ## RELATIONSHIPS
  belongs_to :external_indicator

  #######################
  ## VALIDATIONS
  validates :name, :sort_order, presence: :true

  #######################
  ## SCOPES
  scope :sorted, -> { order(sort_order: :asc) }

  #######################
  #######################
  private

  def has_required_translations?(trans)
    trans.name.present?
  end

  def add_missing_translations(default_trans)
    self.name = default_trans.name if self["name_#{Globalize.locale}"].blank?
  end
end
