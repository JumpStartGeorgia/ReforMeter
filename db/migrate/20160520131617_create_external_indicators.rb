class CreateExternalIndicators < ActiveRecord::Migration
  def up
    create_table :external_indicators do |t|
      t.integer :indicator_type, limit: 1
      t.integer :chart_type, limit: 1
      t.integer :scale_type, limit: 1
      t.integer :min, limit: 2
      t.integer :max, limit: 2
      t.boolean :show_on_home_page, default: false
      t.boolean :is_public, default: false

      t.timestamps null: false
    end

    ExternalIndicator.create_translation_table! title: :string, subtitle: :string, description: :text, data: :text
    add_index :external_indicator_translations, :title

    create_join_table :external_indicators, :reforms
  end

  def down
    drop_table :external_indicators
    ExternalIndicator.drop_translation_table!
    drop_join_table :external_indicators, :reforms
  end
end
