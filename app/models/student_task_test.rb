class StudentTaskTest < ActiveRecord::Base
  belongs_to :student_task
  belongs_to :test
end
