class CreateTestDriverFiles < ActiveRecord::Migration
  def change
    create_table :test_driver_files do |t|
      t.belongs_to :test_driver, index: true
      t.string :name
    end
  end
end
