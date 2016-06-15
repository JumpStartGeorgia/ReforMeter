# == Schema Information
#
# Table name: experts
#
#  id                  :integer          not null, primary key
#  is_active           :boolean          default(TRUE)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  avatar_file_name    :string(255)
#  avatar_content_type :string(255)
#  avatar_file_size    :integer
#  avatar_updated_at   :datetime
#

class Expert < ActiveRecord::Base
  #######################
  ## ATTACHED FILE
  has_attached_file :avatar,
                    :url => "/system/expert_avatar/:id/:style/:basename.:extension",
                    :styles => {
                        :'100x100' => {:geometry => "100x100#"},
                        :'50x50' => {:geometry => "50x50#"}
                    },
                    :convert_options => {
                      :'100x100' => '-quality 85',
                      :'50x50' => '-quality 85'
                    },
                    :default_url => "missing/expert_avatar/:style/default_user.png"


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
  validates_attachment :avatar,
    content_type: { content_type: ["image/jpeg", "image/png"] },
    size: { in: 0..4.megabytes },
    if: Proc.new {|x| x.avatar.present? }


  #######################
  ## SCOPES
  scope :sorted, -> {with_translations(I18n.locale).order(name: :asc)}


end
