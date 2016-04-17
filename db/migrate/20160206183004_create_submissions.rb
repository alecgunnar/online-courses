class CreateSubmissions < ActiveRecord::Migration
  def change
    create_table :submissions do |t|
      t.belongs_to :user
      t.belongs_to :assessment
      t.string :file
      t.decimal :grade, default: 0
      t.boolean :grade_approved, default: false
      t.boolean :graded, default: false
      t.string :result_sourcedid
      t.datetime :upload_date
      t.datetime :graded_date
    end

    add_index :submissions, :user_id
    add_index :submissions, :assessment_id
  end
end
