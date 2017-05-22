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

class ExternalIndicatorIndex < AddMissingTranslation
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

  #######################
  ## SCOPES
  scope :sorted, -> { order(sort_order: :asc) }

  #######################
  #######################
  private

  # def has_required_translations?(trans)
  #   trans.name.present? && trans.short_name.present?
  # end

  # def add_missing_translations(default_trans)
  #   self.name = default_trans.name if self["name_#{Globalize.locale}"].blank?
  #   self.short_name = default_trans.short_name if self["short_name_#{Globalize.locale}"].blank?
  # end

  def required_translation_fields
    return ['name', 'short_name']
  end

end
