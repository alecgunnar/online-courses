class CreateGrades < ActiveRecord::Migration
  def change
    create_table :grades do |t|
      t.belongs_to :users, index: true
      t.belongs_to :assessment, index: true
      t.decimal :grade
    end
  end
end
