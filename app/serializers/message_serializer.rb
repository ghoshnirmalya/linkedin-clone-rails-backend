class MessageSerializer < ActiveModel::Serializer
  attributes :id, :body, :read
  has_one :conversation
  has_one :user
end
