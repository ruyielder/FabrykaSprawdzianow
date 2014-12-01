class RenameStudentTasksTestsToStudentTaskTests < ActiveRecord::Migration
  def change
    rename_table :student_tasks_tests, :student_task_tests
  end
end