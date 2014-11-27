class Task < ActiveRecord::Base
  validates :question, presence: true
  validates :tags_line, presence: true

  belongs_to :author, :class_name => 'User'
  has_and_belongs_to_many :user_tags
  has_many :student_tasks
  has_many :students, through: :student_tasks
end