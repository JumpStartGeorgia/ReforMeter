class CreateExternalIndicatorIndices < ActiveRecord::Migration
  def self.up
    create_table :external_indicator_indices do |t|
      t.integer :external_indicator_id
      t.integer :change_multiplier, limit: 1, default: 1
      t.integer :sort_order, limit: 1, default: 1

      t.timestamps null: false
    end

    add_index :external_indicator_indices, :external_indicator_id
    add_index :external_indicator_indices, :sort_order

    ExternalIndicatorIndex.create_translation_table! name: :string, short_name: :string, description: :text
    add_index :external_indicator_index_translations, :name
  end

  def self.down
    drop_table :external_indicator_indices
    ExternalIndicatorIndex.drop_translation_table!
  end

end
