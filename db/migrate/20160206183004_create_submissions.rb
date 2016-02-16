class CreateSubmissions < ActiveRecord::Migration
  def change
    create_table :submissions do |t|
      t.belongs_to :user, index: true
      t.belongs_to :assessment, index: true
      t.decimal :grade
    end
  end
end
