class AddExtraTextToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :extra_text, :string
  end
end
