class Company < ApplicationRecord
  validates_presence_of :name

  has_and_belongs_to_many :users
  has_many :jobs
end
