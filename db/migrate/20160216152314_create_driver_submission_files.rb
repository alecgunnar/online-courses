class CreateDriverSubmissionFiles < ActiveRecord::Migration
  def change
    create_table :driver_submission_files do |t|
      t.belongs_to :submission, index: true
      t.belongs_to :test_driver_file, index: true
      t.string :path
    end
  end
end
