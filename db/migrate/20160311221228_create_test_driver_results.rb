class CreateTestDriverResults < ActiveRecord::Migration
  def change
    create_table :test_driver_results do |t|
      t.belongs_to :submission
      t.belongs_to :test_driver
      t.text :output
      t.text :error
      t.decimal :grade
      t.boolean :success, default: false
    end

    add_index :test_driver_results, :submission_id
    add_index :test_driver_results, :test_driver_id
  end
end
