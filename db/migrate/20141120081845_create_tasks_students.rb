class CreateTasksStudents < ActiveRecord::Migration
  def change
    create_table :tasks_students do |t|
      t.references :task
      t.references :student
      t.timestamps
    end
  end
end