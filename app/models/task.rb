class Task < ActiveRecord::Base
  validates :question, presence: true
  validates :tags_line, presence: true

  belongs_to :author, :class_name => 'User'

  has_many :task_user_tags
  has_many :user_tags, through: :task_user_tags

  has_many :student_tasks
  has_many :students, through: :student_tasks
end