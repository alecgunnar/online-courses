class ChangeGradingFields < ActiveRecord::Migration
  def change
    add_column :test_driver_results, :grade, :decimal
    add_column :test_driver_result_files, :grade, :decimal
    add_column :test_driver_files, :points, :decimal

    remove_column :submissions, :grade
  end
end
