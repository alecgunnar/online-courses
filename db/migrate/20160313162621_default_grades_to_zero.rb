class DefaultGradesToZero < ActiveRecord::Migration
  def change
    change_column :test_driver_results, :grade, :decimal, default: 0
    change_column :test_driver_result_files, :grade, :decimal, default: 0
  end
end
