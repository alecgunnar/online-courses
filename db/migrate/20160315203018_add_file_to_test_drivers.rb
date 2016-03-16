class AddFileToTestDrivers < ActiveRecord::Migration
  def change
    add_column :test_drivers, :file, :string
  end
end
