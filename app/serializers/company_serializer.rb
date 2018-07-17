class CompanySerializer < ActiveModel::Serializer
  attributes :id, :name

  has_many :users
  has_many :jobs
end
