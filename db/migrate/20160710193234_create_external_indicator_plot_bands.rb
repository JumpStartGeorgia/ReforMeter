class CreateExternalIndicatorPlotBands < ActiveRecord::Migration
  def self.up
    create_table :external_indicator_plot_bands do |t|
      t.integer :external_indicator_id
      t.integer :from
      t.integer :to

      t.timestamps null: false
    end

    add_index :external_indicator_plot_bands, :external_indicator_id
    add_index :external_indicator_plot_bands, [:from, :to]

    ExternalIndicatorPlotBand.create_translation_table! name: :string
    add_index :external_indicator_plot_band_translations, :name
  end

  def self.down
    drop_table :external_indicator_plot_bands
    ExternalIndicatorPlotBand.drop_translation_table!
  end

end
