# == Schema Information
#
# Table name: reports
#
#  id                     :integer          not null, primary key
#  is_active              :boolean          default(TRUE)
#  report_en_file_name    :string(255)
#  report_en_content_type :string(255)
#  report_en_file_size    :integer
#  report_en_updated_at   :datetime
#  report_ka_file_name    :string(255)
#  report_ka_content_type :string(255)
#  report_ka_file_size    :integer
#  report_ka_updated_at   :datetime
#  slug                   :string(255)
#  report_date            :date
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class Report < ActiveRecord::Base

  #######################
  ## TRANSLATIONS

  translates :title, :slug, :fallbacks_for_empty_translations => true
  globalize_accessors

  #######################
  ## ATTACHED FILE
  has_attached_file :report_en,
                    :url => "/system/reports/:id/en/:basename.:extension",
                    :use_timestamp => false

  has_attached_file :report_ka,
                    :url => "/system/reports/:id/ka/:basename.:extension",
                    :use_timestamp => false

  #######################
  ## VALIDATIONS

  validates :title, :report_date, presence: :true
  validates_uniqueness_of :title
  validates_attachment_content_type :report_en, :content_type => 'application/pdf'
  validates_attachment_content_type :report_ka, :content_type => 'application/pdf'

  #######################
  ## SLUG DEFINITION (friendly_id)

  extend FriendlyId
  friendly_id :title, use: [:globalize, :history, :slugged]

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
  scope :sorted, -> { with_translations(I18n.locale).order(report_date: :desc, title: :asc) }


  #######################
  ## METHODS

  def report(locale=I18n.locale)
    locale = locale.to_sym
    locale = I18n.locale if !I18n.available_locales.include?(locale)

    return locale == :en ? report_en : report_ka
  end



end
