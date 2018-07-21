class Conversation < ApplicationRecord
  belongs_to :sender, :class_name => "User"
  belongs_to :recipient, :class_name => "User"

  validates_uniqueness_of :sender_id, :scope => :recipient_id
end
