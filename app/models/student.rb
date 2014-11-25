class Student < ActiveRecord::Base
  belongs_to :teacher, :class_name => 'User'
  validates :name, presence: true
  has_many :student_tasks
  has_many :tasks, through: :student_tasks
end
