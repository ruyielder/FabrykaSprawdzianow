class CreateStudentTasksTests < ActiveRecord::Migration
  def change
    create_table :student_tasks_tests do |t|
      t.references :student_task
      t.references :test
      t.timestamps
    end
  end
end
