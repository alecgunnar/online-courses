class AddInstructorToAssessment < ActiveRecord::Migration
  def change
    add_column :assessments, :instructor, :integer
  end
end
