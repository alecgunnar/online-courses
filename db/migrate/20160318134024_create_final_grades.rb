class CreateFinalGrades < ActiveRecord::Migration
  def change
    create_table :final_grades do |t|
      t.belongs_to :user
      t.belongs_to :assessment
      t.belongs_to :submission
    end

    add_index :final_grades, :user_id
    add_index :final_grades, :assessment_id
    add_index :final_grades, :submission_id
  end
end
