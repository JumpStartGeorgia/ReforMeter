class CreateQuarters < ActiveRecord::Migration
  def up
    create_table :quarters do |t|
      t.integer :quarter, null: false, limit: 1 #tinyint
      t.integer :year, null: false, limit: 2 #smallint
      t.boolean :is_public, default: false
      t.string :slug, null: false

      t.timestamps null: false
    end

    add_index :quarters, [:year, :quarter], unique: true
    add_index :quarters, :slug, unique: true

    Quarter.create_translation_table! summary_good: :string, summary_bad: :string
  end

  def down
    drop_table :quarters
    Quarter.drop_translation_table!
  end

end
