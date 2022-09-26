require "rails_helper"
RSpec.describe Review, type: :model do
  let(:author) { Author.create!(name: "Taylor Swift") }
  let(:category) { Category.create!(name: "Some food") }
  let(:recipe) do 
    Recipe.create!(
      name: "Porridge (too hot)", 
      author: author, 
      duration_in_minutes: 93,
      category: category
    )
  end

  describe "#valid?" do
    let(:review) do
      Review.new(
        author: author, 
        recipe: recipe, 
        rating: 3, 
        body: "Too cold actually"
      )
    end

    it "requires author association" do
      review.author = nil

      expect(review).not_to be_valid
      expect(review.errors[:author]).to include("must exist")
    end

    it "requires recipe association" do
      review.recipe = nil
      
      expect(review).not_to be_valid
      expect(review.errors[:recipe]).to include("must exist")
    end

    it "requires numeric rating" do
      review.rating = "heyyyyyy"

      expect(review).not_to be_valid
      expect(review.errors[:rating]).to include("is not a number")
    end

    it "requires presence of rating" do
      review.rating = nil

      expect(review).not_to be_valid
      expect(review.errors[:rating]).to include("is not a number")
    end

    it "disallows rating less than 0" do
      review.rating = -1

      expect(review).not_to be_valid
      expect(review.errors[:rating]).to include("must be greater than or equal to 0")
    end

    it "disallows rating greater than 5" do
      review.rating = 6
      
      expect(review).not_to be_valid
      expect(review.errors[:rating]).to include("must be less than or equal to 5")
    end

    it "allows null body" do
      review.body = nil
      expect(review).to be_valid
    end
  end
end