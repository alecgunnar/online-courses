class CreateSubmissions < ActiveRecord::Migration
  def change
    create_table :submissions do |t|
      t.belongs_to :user
      t.belongs_to :assessment
      t.string :file
      t.datetime :upload_date
      t.boolean :grade_approved, default: false
      t.boolean :graded, default: false
    end

    add_index :submissions, :user_id
    add_index :submissions, :assessment_id
  end
end
