class ConversationSerializer < ActiveModel::Serializer
  attributes :id
  has_one :sender
  has_one :recipient
end
