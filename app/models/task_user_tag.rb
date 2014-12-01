class TaskUserTag < ActiveRecord::Base
  belongs_to :task
  belongs_to :user_tag
end