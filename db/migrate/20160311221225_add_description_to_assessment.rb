class AddDescriptionToAssessment < ActiveRecord::Migration
  def change
    add_column :assessments, :description, :string, null: true
  end
end
