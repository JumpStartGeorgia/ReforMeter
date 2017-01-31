class MoveReportFields < ActiveRecord::Migration
  def self.up
    change_table :reform_surveys do |t|
      t.attachment :report_en
      t.attachment :report_ka
    end
    change_table :quarters do |t|
      t.attachment :report_en
      t.attachment :report_ka
    end

    remove_attachment :quarter_translations, :report
    remove_attachment :reform_survey_translations, :report
  end

  def self.down
    change_table :quarter_translations do |t|
      t.attachment :report
    end
    change_table :reform_survey_translations do |t|
      t.attachment :report
    end

    remove_attachment :quarters, :report_en
    remove_attachment :quarters, :report_ka
    remove_attachment :reform_surveys, :report_en
    remove_attachment :reform_surveys, :report_ka
  end
end
