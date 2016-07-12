class CreateExternalIndicatorTimes < ActiveRecord::Migration
  def up
    create_table :external_indicator_times do |t|
      t.integer :external_indicator_id
      t.integer :sort_order, limit: 1, default: 1
      t.decimal :overall_value, :precision => 5, :scale => 2
      t.integer :overall_change, length: 1

      t.timestamps null: false
    end

    add_index :external_indicator_times, :external_indicator_id
    add_index :external_indicator_times, :sort_order

    ExternalIndicatorTime.create_translation_table! name: :string
    add_index :external_indicator_time_translations, :name
  end

  def down
    drop_table :external_indicator_times
    ExternalIndicatorTime.drop_translation_table!
  end

end
