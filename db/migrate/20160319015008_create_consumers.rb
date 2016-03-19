class CreateConsumers < ActiveRecord::Migration
  def change
    create_table :consumers do |t|
      t.string :key
      t.string :outcome_url
    end

    add_index :consumers, :key, unique: true
  end
end
