class FixDecimalLength < ActiveRecord::Migration
  def up
    change_column :external_indicator_data, :value, :decimal, null: false, :precision => 9, :scale => 2
  end

  def down
    change_column :external_indicator_data, :value, :decimal, null: false, :precision => 5, :scale => 2
  end
end
