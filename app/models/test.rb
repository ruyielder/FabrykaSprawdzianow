class Test < ActiveRecord::Base
  belongs_to :student
  has_and_belongs_to_many :student_tasks

  def tasks
    student_tasks.map &:task #{|student_task| student_task.task}
  end
end
