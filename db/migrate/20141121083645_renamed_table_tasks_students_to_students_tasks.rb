class RenamedTableTasksStudentsToStudentsTasks < ActiveRecord::Migration
  def change
    rename_table(:tasks_students, :students_tasks)
  end
end
