class ExpandExperts < ActiveRecord::Migration
  def change
    add_column :experts, :expert_type, :integer
    add_column :experts, :reform_id, :integer

    add_index :experts, :expert_type
    add_index :experts, :reform_id
  end
end
