# == Schema Information
#
# Table name: page_contents
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class PageContent < ActiveRecord::Base
  #######################
  ## TRANSLATIONS

  translates :title, :content, :fallbacks_for_empty_translations => true
  globalize_accessors

  #######################
  ## VALIDATIONS

  validates :name, presence: :true, uniqueness: :true

end
