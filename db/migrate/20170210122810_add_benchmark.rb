class AddBenchmark < ActiveRecord::Migration
  def change
    add_column :external_indicators, :has_benchmark, :boolean, default: false
    add_column :external_indicator_data, :is_benchmark, :boolean, default: false
    add_column :external_indicator_translations, :benchmark_title, :string
  end
end
