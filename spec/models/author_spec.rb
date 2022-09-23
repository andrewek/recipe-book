# == Schema Information
#
# Table name: authors
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Author, type: :model do
  let(:category) { Category.create!(name: "Some food") }
  
  it "validates presence of name" do
    a = Author.new(name: nil)

    expect(a).not_to be_valid
    expect(a.errors.full_messages).to include("Name is too short (minimum is 2 characters)")
  end

  it "validates length of name" do
    a = Author.new(name: nil) # <-- make a single character

    expect(a).not_to be_valid
    expect(a.errors.full_messages).to include("Name is too short (minimum is 2 characters)")
  end

  describe "scopes" do
    describe "#search_all_authors" do
      it "searches" do
        a_1 = Author.create!(name: "Keira Knightley")
        a_2 = Author.create!(name: "Jane Austen")
        a_3 = Author.create!(name: "Elizabeth Bennett")

        r_1 = Recipe.create!(name: "Chicken Sandwich", author_id: a_1.id, duration_in_minutes: 20, category: category)
        r_2 = Recipe.create!(name: "Spaghetti", author_id: a_2.id, duration_in_minutes: 45, category: category)
        r_3 = Recipe.create!(name: "Pot Roast", author_id: a_1.id, duration_in_minutes: 100, category: category)

        result = Author.search_all_authors("Jane")
        
        expect(result).to include(a_2)
        expect(result).not_to include(a_1)
        expect(result).not_to include(a_3)
      end
    end

    describe "#oldest_recipe" do
      it "retrieves oldest recipe" do
        a = Author.create!(name: "Keira Knightley")

        r_1 = Recipe.create!(name: "Chicken Sandwich", author: a, duration_in_minutes: 20, category: category)
        r_2 = Recipe.create!(name: "Spaghetti", author: a, duration_in_minutes: 45, category: category, created_at: 1.month.ago)
        r_3 = Recipe.create!(name: "Pot Roast", author: a, duration_in_minutes: 100, category: category, created_at: 2.days.ago)

        result = a.oldest_recipe

        expect(r_2).to eq result
      end
    end

    describe "#newest_recipe" do
      it "retrieves newest recipe" do
        a = Author.create!(name: "Keira Knightley")

        r_1 = Recipe.create!(name: "Chicken Sandwich", author: a, duration_in_minutes: 20, category: category)
        r_2 = Recipe.create!(name: "Spaghetti", author: a, duration_in_minutes: 45, category: category, created_at: 1.month.ago)
        r_3 = Recipe.create!(name: "Pot Roast", author: a, duration_in_minutes: 100, category: category, created_at: 2.days.ago)

        result = a.newest_recipe

        expect(r_1).to eq result
      end
    end
  end
end