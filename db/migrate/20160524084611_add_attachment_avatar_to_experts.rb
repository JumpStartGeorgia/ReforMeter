class AddAttachmentAvatarToExperts < ActiveRecord::Migration
  def self.up
    change_table :experts do |t|
      t.attachment :avatar
    end
  end

  def self.down
    remove_attachment :experts, :avatar
  end
end
