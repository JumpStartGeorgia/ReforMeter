class CreateReports < ActiveRecord::Migration
  def up
    create_table :reports do |t|
      t.boolean :is_active, default: true
      t.attachment :report_en
      t.attachment :report_ka
      t.string :slug#, null: false
      t.date :report_date

      t.timestamps null: false
    end

    add_index :reports, :is_active
    add_index :reports, :slug, unique: true
    add_index :reports, :report_date

    Report.create_translation_table! title: :string, slug: :string
    add_index :report_translations, :title
    add_index :report_translations, :slug
    
  end

  def down
    drop_table :reports
    Report.drop_translation_table!
  end
end
