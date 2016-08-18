class AddSortOrderToExternalIndicators < ActiveRecord::Migration
  def change
    add_column :external_indicators, :sort_order, :integer, default: nil
    add_index :external_indicators, :sort_order
  end
end
