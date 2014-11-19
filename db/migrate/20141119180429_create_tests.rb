class CreateTests < ActiveRecord::Migration
  def change
    create_table :tests do |t|
      t.references :student, index: true
      t.references :user
      t.timestamps
    end
    rename_column :tests, :user_id, :author_id
  end
end
