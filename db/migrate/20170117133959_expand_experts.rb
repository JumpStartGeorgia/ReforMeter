class ExpandExperts < ActiveRecord::Migration
  def up
    add_column :experts, :expert_type, :integer
    add_column :experts, :reform_id, :integer

    add_index :experts, :expert_type
    add_index :experts, :reform_id

    # all existing experts are steering committee, so assign the type
    Expert.update_all(expert_type: Expert::EXPERT_TYPES[:steering_committee])

  end

  def down

    remove_index :experts, :expert_type
    remove_index :experts, :reform_id

    remove_column :experts, :expert_type, :integer
    remove_column :experts, :reform_id, :integer

  end
end
