class Message < ApplicationRecord
  validates_presence_of :body, :conversation_id, :user_id

  belongs_to :conversation
  belongs_to :user

  def self.search(search)
    if search.blank? # blank? covers both nil and empty string
      all
    else
      where("lower(body) LIKE ?", "%#{search.downcase}%")
    end
  end
end
