class CreateExternalIndicatorCountries < ActiveRecord::Migration
  def self.up
    create_table :external_indicator_countries do |t|
      t.integer :external_indicator_id
      t.integer :sort_order, limit: 1, default: 1


      t.timestamps null: false
    end

    add_index :external_indicator_countries, :external_indicator_id
    add_index :external_indicator_countries, :sort_order

    ExternalIndicatorCountry.create_translation_table! name: :string
    add_index :external_indicator_country_translations, :name
  end

  def self.down
    drop_table :external_indicator_countries
    ExternalIndicatorCountry.drop_translation_table!
  end

end
