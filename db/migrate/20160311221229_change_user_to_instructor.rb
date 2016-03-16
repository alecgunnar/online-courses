class ChangeUserToInstructor < ActiveRecord::Migration
  def change
  	rename_column :assessments, :user_id, :instructor_id
  end
end
