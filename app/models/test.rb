class Test < ActiveRecord::Base
  belongs_to :student

  has_many :student_task_tests, dependent: :destroy
  has_many :student_tasks, through: :student_task_tests

  validates :title, presence: true

  def tasks
    student_tasks.map &:task
  end

  def filename
    "#{student.name}_#{created_at.to_date}"
  end

  def solution_filename
    "#{student.name}_ODP_#{created_at.to_date}"
  end
end
