class AddAttachmentReportToQuarters < ActiveRecord::Migration
  def self.up
    change_table :quarter_translations do |t|
      t.attachment :report
    end
  end

  def self.down
    remove_attachment :quarter_translations, :report
  end
end
