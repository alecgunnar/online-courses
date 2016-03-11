class CreateDriverSubmissionFiles < ActiveRecord::Migration
  def change
    create_table :test_driver_result_files do |t|
      t.belongs_to :test_driver_result, index: true
      t.belongs_to :test_driver_file, index: true
      t.string :path
    end
  end
end
