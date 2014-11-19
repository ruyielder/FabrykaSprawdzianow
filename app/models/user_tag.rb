class UserTag < ActiveRecord::Base
  belongs_to :user
  validates :tag, presence: true
  validates :user_id, presence: true
  has_and_belongs_to_many :tasks

end
