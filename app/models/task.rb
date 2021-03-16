class Task < ApplicationRecord
  enum priority: { low: 0, medium: 1, high: 2 }
  enum status: { pending: 0, processing: 1, completed: 2 }
  
  # validations
  validates :title, presence: true, uniqueness: true
  validates :description, presence: true
  validates :priority, presence: true, inclusion: { in: %w(low medium high) }
  validates :status, presence: true, inclusion: { in: %w(pending processing completed) }
  validates :start_time, presence: true
  validates :end_time, presence: true

  # scopes
  scope :with_order, -> (order){ order("created_at #{order}") if order }
end
