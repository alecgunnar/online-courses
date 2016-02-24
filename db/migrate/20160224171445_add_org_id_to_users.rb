class AddOrgIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :org_id, :string

    add_index :users, :org_id, unique: true
  end
end
