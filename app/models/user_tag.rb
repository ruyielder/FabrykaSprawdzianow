class UserTag < ActiveRecord::Base
  belongs_to :user
  validates :tag, presence: true
  validates :user_id, presence: true
end
