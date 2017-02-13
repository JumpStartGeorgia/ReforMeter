class QuarterIdDefaults < ActiveRecord::Migration
  def change
    change_column :reform_surveys, :quarter_id, :integer, limit: 4, null: true
  end
end
