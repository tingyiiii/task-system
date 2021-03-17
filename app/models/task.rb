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
  validate :end_time_after_start_time

  # scopes
  scope :order_by_created_at, -> (order){ order("created_at #{order}") if order }
  scope :order_by_end_time, -> (order){ order("end_time #{order}") if order }

  private
  def end_time_after_start_time
    return if end_time.blank? || start_time.blank?
 
    if end_time <= start_time
      errors.add(:end_time, I18n.t('tasks.end_time_after_start_time')) 
    end
  end
end
