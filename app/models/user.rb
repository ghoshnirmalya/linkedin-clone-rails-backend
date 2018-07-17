class User < ApplicationRecord
  validates_presence_of :email, :password
  validates_uniqueness_of :email

  has_and_belongs_to_many :companies

  has_secure_password
end
