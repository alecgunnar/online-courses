class CreateAssessments < ActiveRecord::Migration
  def change
    create_table :assessments do |t|
      t.string :name
      t.string :specs_file
      t.integer :submit_limit
      t.string :context
      t.belongs_to :user
      t.text :description
      t.datetime :due_date
    end

    add_index :assessments, :context
    add_index :assessments, :user_id
  end
end
