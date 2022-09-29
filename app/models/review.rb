# == Schema Information
#
# Table name: reviews
#
#  id         :bigint           not null, primary key
#  body       :text             default("")
#  rating     :integer          default(5), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  author_id  :bigint
#  recipe_id  :bigint
#
# Indexes
#
#  index_reviews_on_author_id  (author_id)
#  index_reviews_on_recipe_id  (recipe_id)
#
class Review < ApplicationRecord
  # Validations
  validates :rating, numericality: {
    less_than_or_equal_to: 5,
    greater_than_or_equal_to: 0
  }
  
  # Associations
  belongs_to :author
  belongs_to :recipe

  # Query Scopes
  scope :rating_is_at_least, -> (rating) { where("rating >= ? ", rating)}
  scope :rating_is_at_most, -> (rating) { where("rating <= ? ", rating)}
end
