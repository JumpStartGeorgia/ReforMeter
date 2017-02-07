class AddRelationshipsToVerdicts < ActiveRecord::Migration
  def change
    add_reference :news, :verdict, index: true
    add_reference :reform_surveys, :verdict, index: true
  end
end
