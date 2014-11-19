class CreateTaskUserTags < ActiveRecord::Migration
  def change
    create_table :tasks_user_tags do |t|
      t.references :task
      t.references :user_tag

      t.timestamps
    end
  end
end
