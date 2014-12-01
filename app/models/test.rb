class Test < ActiveRecord::Base
  belongs_to :student
  has_and_belongs_to_many :student_tasks
  validates :title, presence: true

  def tasks
    student_tasks.map &:task #{|student_task| student_task.task}
  end

  def filename
    "#{student.name}_#{created_at.to_date}.pdf"
  end
end
