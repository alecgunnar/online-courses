class CreateAssessments < ActiveRecord::Migration
  def change
    create_table :assessments do |t|
      t.string :context_id, null: false
      t.string :label
      t.integer :submit_limit, null: true, default: nil
    end

    add_index :assessments, :context_id, unique: true
  end
end
