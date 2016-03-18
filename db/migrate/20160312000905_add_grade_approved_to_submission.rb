class AddGradeApprovedToSubmission < ActiveRecord::Migration
  def change
    add_column :submissions, :grade_approved, :boolean, default: false
  end
end
