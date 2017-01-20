class AddRoundFlag < ActiveRecord::Migration
  def change
    add_column :external_indicators, :use_decimals, :boolean, default: false
  end
end
