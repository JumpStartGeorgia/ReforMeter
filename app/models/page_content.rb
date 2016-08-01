# == Schema Information
#
# Table name: page_contents
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class PageContent < AddMissingTranslation
  #######################
  ## TRANSLATIONS

  translates :title, :content, :fallbacks_for_empty_translations => true
  globalize_accessors

  #######################
  ## VALIDATIONS

  validates :name, presence: :true, uniqueness: :true

  #######################
  #######################
  private

  def has_required_translations?(trans)
    trans.title.present?
  end

  def add_missing_translations(default_trans)
    self.title = default_trans.title if self["title_#{Globalize.locale}"].blank?
  end
end
