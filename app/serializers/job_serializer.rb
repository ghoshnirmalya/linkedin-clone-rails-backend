class JobSerializer < ActiveModel::Serializer
  attributes :id, :title, :description

  has_one :company
end
