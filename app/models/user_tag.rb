class UserTag < ActiveRecord::Base
  belongs_to :user
  validates :tag, presence: true
  validates :user_id, presence: true
  # has_and_belongs_to_many :tasks
  has_many :task_user_tags, dependent: :destroy
  has_many :tasks, through: :task_user_tags
end
