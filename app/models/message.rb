class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :user

  validates_presence_of :body, :conversation_id, :user_id

  def self.search(search)
    if search.blank? # blank? covers both nil and empty string
      all
    else
      where("lower(body) LIKE ?", "%#{search.downcase}%")
    end
  end
end
