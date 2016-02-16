class CreateAssessments < ActiveRecord::Migration
  def change
    create_table :assessments do |t|
      t.string :name
      t.string :specs_file_name
      t.integer :submit_limit, null: true, default: nil
      t.string :context, null: false
    end

    add_index :assessments, :context, unique: true
  end
end
