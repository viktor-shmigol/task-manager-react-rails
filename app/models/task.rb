class Task < ActiveRecord::Base
  validates :name, :description, presence: true
end
