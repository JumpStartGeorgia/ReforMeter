class CreateReformColors < ActiveRecord::Migration
  def change
    create_table :reform_colors do |t|
      t.string :hex
      t.integer :r, limit: 2
      t.integer :g, limit: 2
      t.integer :b, limit: 2

      t.timestamps null: false
    end

    add_column :reforms, :reform_color_id, :integer
    add_index  :reforms, :reform_color_id
  end
end
