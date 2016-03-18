class AddGradedToSubmissions < ActiveRecord::Migration
  def change
    add_column :submissions, :graded, :boolean, default: false
  end
end
