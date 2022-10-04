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
require "rails_helper"

RSpec.describe Review, type: :model do
  describe "#valid?" do

    it "requires author association" do
      # review.author = nil
      review = build(:review, author: nil)

      expect(review).not_to be_valid
      expect(review.errors[:author]).to include("must exist")
    end

    it "requires recipe association" do
      review = build(:review, recipe: nil)
      
      expect(review).not_to be_valid
      expect(review.errors[:recipe]).to include("must exist")
    end

    it "requires numeric rating" do
      review = build(:review, rating: "heyyyyyy")

      expect(review).not_to be_valid
      expect(review.errors[:rating]).to include("is not a number")
    end

    it "requires presence of rating" do
      review = build(:review, rating: nil)

      expect(review).not_to be_valid
      expect(review.errors[:rating]).to include("is not a number")
    end

    it "disallows rating less than 0" do
      review = build(:review, rating: -1)

      expect(review).not_to be_valid
      expect(review.errors[:rating]).to include("must be greater than or equal to 0")
    end

    it "disallows rating greater than 5" do
      review = build(:review, rating: 6)

      expect(review).not_to be_valid
      expect(review.errors[:rating]).to include("must be less than or equal to 5")
    end

    it "allows null body" do
      review = build(:review, body: nil)
      expect(review).to be_valid
    end
  end
  
  describe ".rating_is_at_most" do
    it "returns the correct results" do
      r_1 = create(:review, rating: 1)
      r_2 = create(:review, rating: 3)
      r_3 = create(:review, rating: 5)
  
      result = Review.rating_is_at_most(3)
  
      expect(result).to include(r_1)
      expect(result).to include(r_2)
      expect(result).not_to include(r_3)
    end
  end

  describe ".rating_is_at_least" do
    it "returns the correct results" do
      r_1 = create(:review, rating: 1)
      r_2 = create(:review, rating: 3)
      r_3 = create(:review, rating: 5)

      result = Review.rating_is_at_least(3)

      expect(result).not_to include(r_1)
      expect(result).to include(r_2)
      expect(result).to include(r_3)
    end
  end
end
