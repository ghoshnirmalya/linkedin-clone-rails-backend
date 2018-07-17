class Job < ApplicationRecord
  validates_presence_of :title, :description, :company_id

  belongs_to :company
end
