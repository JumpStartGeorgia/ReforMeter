class AddExpertSortOrder < ActiveRecord::Migration
  def change
    add_column :experts, :sort_order, :integer, limit: 2, default: 1
    add_index :experts, :sort_order 
  end
end
