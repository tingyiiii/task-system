class Task < ApplicationRecord
  # validations
  validates :title, presence: true
  validates :description, presence: true
end
