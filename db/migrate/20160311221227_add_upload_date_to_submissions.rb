class AddUploadDateToSubmissions < ActiveRecord::Migration
  def change
    add_column :submissions, :upload_date, :datetime, null: false
  end
end
