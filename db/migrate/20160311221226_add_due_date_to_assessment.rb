class AddDueDateToAssessment < ActiveRecord::Migration
  def change
    add_column :assessments, :due_date, :datetime, null: true
  end
end
