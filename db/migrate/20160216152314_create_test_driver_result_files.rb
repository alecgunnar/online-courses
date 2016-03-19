class CreateTestDriverResultFiles < ActiveRecord::Migration
  def change
    create_table :test_driver_result_files do |t|
      t.belongs_to :test_driver_result
      t.belongs_to :test_driver_file
      t.string :path
      t.decimal :grade
    end

    add_index :test_driver_result_files, :test_driver_result_id
    add_index :test_driver_result_files, :test_driver_file_id
  end
end
