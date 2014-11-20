class Student < ActiveRecord::Base
  belongs_to :teacher, :class_name => 'User'
  validates :name, presence: true
  has_and_belongs_to_many :tasks
end
