class Company < ApplicationRecord
  validates_presence_of :name

  has_and_belongs_to_many :users
  has_many :jobs

  def self.search(search)
    if search.blank? # blank? covers both nil and empty string
      all
    else
      where("lower(name) LIKE ?", "%#{search.downcase}%")
    end
  end
end
