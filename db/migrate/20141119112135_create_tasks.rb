class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :question
      t.string :answer

      t.timestamps
    end
  end
end
