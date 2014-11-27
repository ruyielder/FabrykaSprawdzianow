class AddTagsLineToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :tags_line, :string
  end
end
