class AddStderrAndStatusToTestDriverResults < ActiveRecord::Migration
  def change
    add_column :test_driver_results, :error, :text
    add_column :test_driver_results, :success, :boolean
  end
end
