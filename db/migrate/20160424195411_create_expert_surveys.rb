class CreateExpertSurveys < ActiveRecord::Migration
  def up
    create_table :expert_surveys do |t|
      t.integer :quarter_id, null: false
      t.decimal :overall_score, null: false, :precision => 5, :scale => 2
      t.decimal :category1_score, null: false, :precision => 5, :scale => 2
      t.decimal :category2_score, null: false, :precision => 5, :scale => 2
      t.decimal :category3_score, null: false, :precision => 5, :scale => 2

      t.timestamps null: false
    end

    add_index :expert_surveys, :quarter_id

    ExpertSurvey.create_translation_table! summary: :text, details: :text
  end

  def down
    drop_table :expert_surveys
    ExpertSurvey.drop_translation_table!
  end

end
