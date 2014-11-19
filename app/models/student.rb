class Student < ActiveRecord::Base
  belongs_to :teacher, :class_name => 'User'
  validates :name, presence: true
end
