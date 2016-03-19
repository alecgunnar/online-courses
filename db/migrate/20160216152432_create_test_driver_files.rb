class CreateTestDriverFiles < ActiveRecord::Migration
  def change
    create_table :test_driver_files do |t|
      t.belongs_to :test_driver
      t.string :name
      t.decimal :points
      t.string :file
    end

    add_index :test_driver_files, :test_driver_id
  end
end
