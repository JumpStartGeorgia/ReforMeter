class AddVerdictSummary < ActiveRecord::Migration
  def change
    add_column :verdict_translations, :summary, :text
  end
end
