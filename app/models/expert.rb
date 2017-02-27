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
#  expert_type         :integer
#  reform_id           :integer
#  sort_order          :integer          default(1)
#

class Expert < AddMissingTranslation

  #######################
  ## CONSTANTS
  EXPERT_TYPES = {steering_committee: 1, stakeholder: 2, executive_team: 3}

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
  belongs_to :reform

  #######################
  ## VALIDATIONS

  validates :name, :expert_type, presence: :true
  validates :reform_id, presence: :true, :if => :is_stakeholder?
  validates :expert_type, inclusion: {in: EXPERT_TYPES.values}, :if => "!expert_type.blank?"
  validates_attachment :avatar,
    content_type: { content_type: ["image/jpeg", "image/png"] },
    size: { in: 0..4.megabytes },
    if: Proc.new {|x| x.avatar.present? }
  def is_stakeholder?
    self.expert_type == EXPERT_TYPES[:stakeholder]
  end

  #######################
  ## SORTING
  acts_as_list column: :sort_order, scope: [:expert_type]

  #######################
  ## CALLBACKS
  before_save :reset_reform_id
  # if type is not stakeholder, reset reform id to nil
  def reset_reform_id
    self.reform_id = nil if self.expert_type != EXPERT_TYPES[:stakeholder]

    return true
  end

  #######################
  ## SCOPES
  scope :active, -> { where(is_active: true) }
  scope :sorted, -> { with_translations(I18n.locale).order(sort_order: :asc, name: :asc) }
  scope :with_reforms, -> {includes(:reform => :translations)}

  def self.by_type(type)
    where(expert_type: type)
  end
  def self.steering_committee_members
    by_type(EXPERT_TYPES[:steering_committee])
  end
  def self.stakeholders
    by_type(EXPERT_TYPES[:stakeholder])
  end
  def self.executive_team_members
    by_type(EXPERT_TYPES[:executive_team])
  end
  def self.by_reform(reform_id)
    where(reform_id: reform_id)
  end

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
