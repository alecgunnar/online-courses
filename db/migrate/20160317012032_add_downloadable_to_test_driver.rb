class AddDownloadableToTestDriver < ActiveRecord::Migration
  def change
    add_column :test_drivers, :downloadable, :boolean
  end
end
