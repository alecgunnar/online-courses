class AddValanceDataToUsers < ActiveRecord::Migration
  def change
    add_column :users, :token_key, :string, default: nil
    add_column :users, :token_id, :string, default: nil
    add_column :users, :token_sig, :string, default: nil
  end
end
