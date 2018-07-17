class UserSerializer < ActiveModel::Serializer
  attributes :name, :email

  has_many :companies
end
