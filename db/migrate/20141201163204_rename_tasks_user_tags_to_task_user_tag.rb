class RenameTasksUserTagsToTaskUserTag < ActiveRecord::Migration
  def change
    rename_table :tasks_user_tags, :task_user_tags
  end
end
