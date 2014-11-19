class Task < ActiveRecord::Base
  belongs_to :author, :class_name => 'User'

  has_and_belongs_to_many :user_tags
end
