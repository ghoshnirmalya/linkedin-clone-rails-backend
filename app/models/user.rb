class User < ApplicationRecord
  validates_presence_of :email, :password
  validates_uniqueness_of :email

  has_and_belongs_to_many :companies
  has_many :conversations
  has_many :messages

  has_secure_password

  def self.search(search)
    if search.blank? # blank? covers both nil and empty string
      all
    else
      where("lower(name) LIKE ?", "%#{search.downcase}%")
    end
  end
end
