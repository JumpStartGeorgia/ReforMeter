class AddScoreChangeFields < ActiveRecord::Migration
  def change
    add_column :expert_surveys, :overall_change, :integer, length: 1
    add_column :expert_surveys, :category1_change, :integer, length: 1
    add_column :expert_surveys, :category2_change, :integer, length: 1
    add_column :expert_surveys, :category3_change, :integer, length: 1

    add_column :reform_surveys, :government_overall_change, :integer, length: 1
    add_column :reform_surveys, :government_category1_change, :integer, length: 1
    add_column :reform_surveys, :government_category2_change, :integer, length: 1
    add_column :reform_surveys, :government_category3_change, :integer, length: 1
    add_column :reform_surveys, :government_category4_change, :integer, length: 1

    add_column :reform_surveys, :stakeholder_overall_change, :integer, length: 1
    add_column :reform_surveys, :stakeholder_category1_change, :integer, length: 1
    add_column :reform_surveys, :stakeholder_category2_change, :integer, length: 1
    add_column :reform_surveys, :stakeholder_category3_change, :integer, length: 1

  end
end
