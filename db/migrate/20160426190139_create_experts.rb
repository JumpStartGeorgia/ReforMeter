class CreateExperts < ActiveRecord::Migration
  def up
    create_table :experts do |t|
      t.boolean :is_active, default: true

      t.timestamps null: false
    end

    add_index :experts, :is_active

    Expert.create_translation_table! name: :string, bio: :text

    create_join_table :experts, :expert_surveys
  end

  def down
    drop_table :experts
    Expert.drop_translation_table!
    drop_join_table :experts, :expert_surveys
  end
end
