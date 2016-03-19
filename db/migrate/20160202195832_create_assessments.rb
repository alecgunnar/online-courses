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
      t.integer :points, default: 0
      t.belongs_to :consumer
    end

    add_index :assessments, :context
    add_index :assessments, :user_id
    add_index :assessments, :consumer_id
  end
end
