class StudentsTasks < ActiveRecord::Base
  belongs_to :student
  belongs_to :task
end
