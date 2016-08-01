class CreateExternalIndicatorData < ActiveRecord::Migration
  def change
    create_table :external_indicator_data do |t|
      t.integer :external_indicator_time_id
      t.integer :country_id
      t.integer :index_id
      t.decimal :value, null: false, :precision => 5, :scale => 2
      t.integer :change, length: 1

      t.timestamps null: false
    end

    add_index :external_indicator_data, :external_indicator_time_id
    add_index :external_indicator_data, :country_id
    add_index :external_indicator_data, :index_id

  end
end
