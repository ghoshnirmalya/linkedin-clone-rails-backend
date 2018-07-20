class Job < ApplicationRecord
  validates_presence_of :title, :description, :company_id

  belongs_to :company

  def self.search(search)
    if search.blank? # blank? covers both nil and empty string
      all
    else
      where("lower(title) LIKE ?", "%#{search.downcase}%")
    end
  end
end
