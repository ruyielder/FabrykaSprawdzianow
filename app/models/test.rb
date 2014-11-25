class Test < ActiveRecord::Base
  belongs_to :student
  has_and_belongs_to_many :student_tasks

  def each_task
    student_tasks.each {|student_task| yield student_task.task}
  end
end
