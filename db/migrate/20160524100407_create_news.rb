class CreateNews < ActiveRecord::Migration
  def self.up
    create_table :news do |t|
      t.integer :quarter_id
      t.integer :reform_id
      t.attachment :image

      t.timestamps null: false
    end

    add_index :news, [:quarter_id, :reform_id]

    News.create_translation_table! title: :string, content: :text, url: :string

    add_index :news_translations, :title
  end

  def self.down
    drop_table :news
    News.drop_translation_table!
  end
end
