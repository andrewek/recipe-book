# name
# id
# duration_in_minutes
# created_at
# updated_at
class Recipe < ApplicationRecord
  # Validations
  validates :name, length: { minimum: 2 }
  validates :duration_in_minutes, presence: true, numericality: { greater_than: 0 }

  # Associations

  # Query Scopes
  scope :short_to_make, -> { makeable_in_under(30) }
  scope :long_to_make, -> { makeable_in_at_least(30) }
  scope :makeable_in_under, ->(duration) { where("duration_in_minutes <= ? ", duration)}
  scope :makeable_in_at_least, ->(duration) { where("duration_in_minutes >= ?", duration)}
end
