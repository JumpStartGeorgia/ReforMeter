class AddReformSurveyReport < ActiveRecord::Migration
  def self.up
    change_table :reform_survey_translations do |t|
      t.attachment :report
    end
  end

  def self.down
    remove_attachment :reform_survey_translations, :report
  end
end
