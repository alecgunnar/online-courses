class CreateTestDriverResults < ActiveRecord::Migration
  def change
    create_table :test_driver_results do |t|
      t.belongs_to :submission
      t.belongs_to :test_driver
      t.text :output
    end
  end
end
