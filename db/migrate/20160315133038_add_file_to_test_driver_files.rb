class AddFileToTestDriverFiles < ActiveRecord::Migration
  def change
    add_column :test_driver_files, :file, :string
  end
end
