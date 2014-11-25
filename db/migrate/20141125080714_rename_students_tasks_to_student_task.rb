class RenameStudentsTasksToStudentTask < ActiveRecord::Migration
  def change
    rename_table :students_tasks, :student_tasks
  end
end
