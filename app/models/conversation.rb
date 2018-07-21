class Conversation < ApplicationRecord
  validates_presence_of :sender_id, :recipient_id
  validates_uniqueness_of :sender_id, :scope => :recipient_id

  belongs_to :sender, :class_name => "User"
  belongs_to :recipient, :class_name => "User"

  has_many :messages, dependent: :destroy
end
