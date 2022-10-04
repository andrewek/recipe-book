# == Schema Information
#
# Table name: authors
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Author < ApplicationRecord
  # Validations
  validates :name, length: { minimum: 2 }

  # Associations
  has_many :recipes, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :kitchens, dependent: :destroy

  # Query Scope
  scope :search_all_authors, -> (token) { where("name ilike ?", "%#{token}%") }

  def average_given_rating
    reviews.average(:rating)
  end

  def newest_recipe
    recipes.newest
  end
  
  def oldest_recipe
    recipes.oldest
  end

  def average_estimated_value
    kitchens.average(:value)
  end
end