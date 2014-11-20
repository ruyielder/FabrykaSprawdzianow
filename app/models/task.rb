class Task < ActiveRecord::Base
  belongs_to :author, :class_name => 'User'

  has_and_belongs_to_many :user_tags
  has_and_belongs_to_many :students

  def tags_line
    names = user_tags.map &:tag
    names.join(', ')
  end
end
