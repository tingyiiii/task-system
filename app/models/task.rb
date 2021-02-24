class Task < ApplicationRecord
  # validations
  validates :title, presence: true, uniqueness: true
  validates :description, presence: true
  validates :priority, presence: true, inclusion: { in: 0..2 }
  validates :status, presence: true, inclusion: { in: 0..2 }
  validates :start_time, presence: true
  validates :end_time, presence: true

  # scopes
  scope :created_time_asc, -> { order("created_at asc") }
  scope :created_time_desc, -> { order("created_at desc") }
end
