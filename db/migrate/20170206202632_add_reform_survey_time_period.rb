class AddReformSurveyTimePeriod < ActiveRecord::Migration
  def up
    add_column :reform_surveys, :time_period, :date
    add_index :reform_surveys, :time_period 

    add_column :reform_surveys, :is_public, :boolean, default: false
    add_index :reform_surveys, :is_public 

    # add value to existing records
    quarters = Quarter.all

    ReformSurvey.all.each do |survey|
      quarter = quarters.select{|x| x.id == survey.quarter_id}.first
      if quarter.present?
        month = quarter.quarter*3 - 2
        survey.time_period = "#{quarter.year}-#{month}-01"
        survey.is_public = quarter.is_public
        survey.save
      end
    end
  end

  def down
    remove_index :reform_surveys, :time_period 
    remove_column :reform_surveys, :time_period

    remove_index :reform_surveys, :is_public 
    remove_column :reform_surveys, :is_public
  end
end
