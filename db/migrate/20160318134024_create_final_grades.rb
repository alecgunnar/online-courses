class CreateFinalGrades < ActiveRecord::Migration
  def change
    create_table :final_grades do |t|
      t.belongs_to :user
      t.belongs_to :assessment
      t.belongs_to :submission
    end
  end
end
