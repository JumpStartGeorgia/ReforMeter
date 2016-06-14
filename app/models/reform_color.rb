# == Schema Information
#
# Table name: reform_colors
#
#  id         :integer          not null, primary key
#  hex        :string(255)
#  r          :integer
#  g          :integer
#  b          :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ReformColor < ActiveRecord::Base
  #######################
  ## RELATIONSHIPS
  has_many :reforms, dependent: :nullify

  #######################
  ## VALIDATIONS

  validates :hex, :r, :g, :b, presence: :true
  validates_uniqueness_of :hex
  validates :hex, length: { is: 7 }

  #######################
  ## CALLBACKS
  before_validation :set_rgb

  def set_rgb
    if hex_changed?
      colors = ( self.hex.match /#(..?)(..?)(..?)/ )[1..3]
      colors.map!{ |x| x + x } if self.hex.size == 4
      self.r = colors[0].hex
      self.g = colors[1].hex
      self.b = colors[2].hex
    end
  end


  #######################
  ## SCOPES
  scope :with_reforms, -> {includes(:reforms )}


  #######################
  ## METHODS

  # get rgb colors in hash format
  def to_hash
    return {
      hex: self.hex,
      r: self.r,
      g: self.g,
      b: self.b
    }
  end

  # return the rgb value in a string format of (r, g, b)
  def rgb
    return "(#{self.r}, #{self.g}, #{self.b})"
  end

  # get the names of the reforms with this color
  def reform_names(delim = ' <br /> ')
    self.reforms.map{|x| x.name}.join(delim)
  end
end
