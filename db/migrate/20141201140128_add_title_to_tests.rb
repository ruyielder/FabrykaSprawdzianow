class AddTitleToTests < ActiveRecord::Migration
  def change
    add_column :tests, :title, :string
  end
end
