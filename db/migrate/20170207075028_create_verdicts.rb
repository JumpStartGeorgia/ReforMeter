class CreateVerdicts < ActiveRecord::Migration
  def up
    create_table :verdicts do |t|
      t.decimal :overall_score, null: false, :precision => 5, :scale => 2
      t.decimal :category1_score, null: false, :precision => 5, :scale => 2
      t.decimal :category2_score, null: false, :precision => 5, :scale => 1
      t.decimal :category3_score, null: false, :precision => 5, :scale => 2
      t.integer :overall_change, :integer, length: 1
      t.integer :category1_change, :integer, length: 1
      t.integer :category2_change, :integer, length: 1
      t.integer :category3_change, :integer, length: 1
      t.boolean :is_public, default: false
      t.string :slug#, null: false
      t.date :time_period

      t.timestamps null: false
    end

    add_index :verdicts, :is_public
    add_index :verdicts, :slug
    add_index :verdicts, :time_period

    Verdict.create_translation_table! title: :string, slug: :string
    add_index :verdict_translations, :title
    add_index :verdict_translations, :slug
  end

  def down
    drop_table :verdicts
    Verdict.drop_translation_table!
  end
end
