class CreateTestDrivers < ActiveRecord::Migration
  def change
    create_table :test_drivers do |t|
      t.belongs_to :assessment
      t.string :name
      t.decimal :points
      t.string :file
      t.boolean :downloadable, default: false
    end

    add_index :test_drivers, :assessment_id
  end
end
