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
  ## ATTACHED FILE
  has_attached_file :avatar,
                    :url => "/system/expert_avatar/:id/:style/:basename.:extension",
                    :styles => {
                        :'168x168' => {:geometry => "168x168#"},
                        :'50x50' => {:geometry => "50x50#"},
                        :'40x40' => {:geometry => "40x40#"}
                    },
                    :convert_options => {
                      :'168x168' => '-quality 85',
                      :'50x50' => '-quality 85',
                      :'40x40' => '-quality 85'
                    },
                    :default_url => "/assets/missing/expert_avatar/:style/default_user.png"


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
    size: { in: 0..4.megabytes }


end
