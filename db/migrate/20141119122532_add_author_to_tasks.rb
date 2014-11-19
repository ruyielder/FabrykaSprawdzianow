class AddAuthorToTasks < ActiveRecord::Migration
  def change
    add_belongs_to(:tasks, :user)
    rename_column(:tasks, :user_id, :author_id)
  end
end
