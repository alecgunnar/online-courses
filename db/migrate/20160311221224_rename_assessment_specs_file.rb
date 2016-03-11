class RenameAssessmentSpecsFile < ActiveRecord::Migration
  def change
  	rename_column :assessments, :specs_file_name, :specs_file
  end
end
