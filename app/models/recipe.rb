# == Schema Information
#
# Table name: recipes
#
#  id                  :bigint           not null, primary key
#  duration_in_minutes :integer          default(30), not null
#  name                :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  author_id           :bigint
#  category_id         :bigint
#
# Indexes
#
#  index_recipes_on_author_id    (author_id)
#  index_recipes_on_category_id  (category_id)
#
class Recipe < ApplicationRecord
  # Validations
  validates :name, length: { minimum: 2 }
  validates :duration_in_minutes, presence: true, numericality: { greater_than: 0 }

  # Associations
  belongs_to :category
  belongs_to :author

  # Query Scopes
  scope :short_to_make, -> { makeable_in_at_most(30) }
  scope :long_to_make, -> { makeable_in_at_least(30) }
  scope :makeable_in_at_most, ->(duration) { where("duration_in_minutes <= ? ", duration)}
  scope :makeable_in_at_least, ->(duration) { where("duration_in_minutes >= ?", duration)}
  scope :name_is_like, ->(token) { where("name ilike ?", "%#{token}%") }
  scope :oldest, -> { order(:created_at).limit(1).first }
  scope :newest, -> { order(created_at: :desc).limit(1).first }
end
