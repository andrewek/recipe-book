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
  # TODO  -> created_at --> joined_on
  #       -> favorite recipe (recipe_id)

  # Associations
  has_many :recipes
  has_many :reviews

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
end