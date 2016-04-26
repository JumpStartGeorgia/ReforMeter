class CreateReformSurveys < ActiveRecord::Migration
  def up
    create_table :reform_surveys do |t|
      t.integer :quarter_id, null: false
      t.integer :reform_id, null: false
      t.decimal :government_overall_score, null: false, :precision => 5, :scale => 2
      t.decimal :government_category1_score, null: false, :precision => 5, :scale => 2
      t.decimal :government_category2_score, null: false, :precision => 5, :scale => 2
      t.decimal :government_category3_score, null: false, :precision => 5, :scale => 2
      t.decimal :government_category4_score, null: false, :precision => 5, :scale => 2
      t.decimal :stakeholder_overall_score, null: false, :precision => 5, :scale => 2
      t.decimal :stakeholder_category1_score, null: false, :precision => 5, :scale => 2
      t.decimal :stakeholder_category2_score, null: false, :precision => 5, :scale => 2
      t.decimal :stakeholder_category3_score, null: false, :precision => 5, :scale => 2

      t.timestamps null: false
    end

    add_index :reform_surveys, :quarter_id
    add_index :reform_surveys, :reform_id

    ReformSurvey.create_translation_table! summary: :text, government_summary: :text, stakeholder_summary: :text
  end

  def down
    drop_table :reform_surveys
    ReformSurvey.drop_translation_table!
  end
end
