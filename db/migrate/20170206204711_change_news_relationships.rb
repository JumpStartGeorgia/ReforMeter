class ChangeNewsRelationships < ActiveRecord::Migration
  def up
    add_column :news, :reform_survey_id, :integer
    add_index :news, :reform_survey_id

    # add values
    News.where('quarter_id is not null and reform_id is not null').each do |news|
      # get the reform survey
      survey = ReformSurvey.where(quarter_id: news.quarter_id, reform_id: news.reform_id).first
      if survey
        news.reform_survey_id = survey.id
        news.save
      end
    end
  end

  def down
    remove_index :news, :reform_survey_id
    remove_column :news, :reform_survey_id
  end
end
