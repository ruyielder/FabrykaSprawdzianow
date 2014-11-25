class Task < ActiveRecord::Base
  belongs_to :author, :class_name => 'User'

  has_and_belongs_to_many :user_tags
  has_many :student_tasks
  has_many :students, through: :student_tasks

  def tags_line
    names = user_tags.map &:tag
    names.join(', ')
  end
end
