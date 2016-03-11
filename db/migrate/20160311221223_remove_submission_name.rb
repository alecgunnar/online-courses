class RemoveSubmissionName < ActiveRecord::Migration
  def change
  	rename_column :submissions, :name, :file
  end
end
