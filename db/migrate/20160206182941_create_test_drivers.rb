class CreateTestDrivers < ActiveRecord::Migration
  def change
    create_table :test_drivers do |t|
      t.belongs_to :assessment, index: true
      t.text :driver
      t.integer :weight
    end
  end
end
