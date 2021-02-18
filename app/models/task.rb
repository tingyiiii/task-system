class Task < ApplicationRecord
  # validations
  validates :title, presence: true
  validates :description, presence: true

  # scopes
  scope :created_time_asc, -> { order("created_at asc") }
  scope :created_time_desc, -> { order("created_at desc") }
end
