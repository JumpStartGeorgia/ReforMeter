class CreateReforms < ActiveRecord::Migration
  def up
    create_table :reforms do |t|
      t.boolean :is_active, default: true
      t.boolean :is_highlight, default: true
      t.string :slug, null: false

      t.timestamps null: false
    end

    add_index :reforms, :is_active
    add_index :reforms, :is_highlight
    add_index :reforms, :slug, unique: true

    Reform.create_translation_table! name: :string, summary: :string, methodology: :text
  end

  def down
    drop_table :reforms
    Reform.drop_translation_table!
  end

end
