# == Schema Information
#
# Table name: recipes
#
#  id                  :bigint           not null, primary key
#  duration_in_minutes :integer          default(30), not null
#  name                :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  category_id         :bigint
#
# Indexes
#
#  index_recipes_on_category_id  (category_id)
#
require 'rails_helper'

RSpec.describe Recipe, type: :model do
  let(:category) { Category.create!(name: "Some food") }

  describe "#valid?" do
    it "checks presence of name" do
      r = Recipe.new(name: nil)

      expect(r).not_to be_valid
      expect(r.errors.full_messages).to include("Name is too short (minimum is 2 characters)")
    end

    it "validates length of name" do
      r = Recipe.new(name: "a")

      expect(r).not_to be_valid
      expect(r.errors.full_messages).to include("Name is too short (minimum is 2 characters)")
    end

    it "validates presence of duration_in_minutes" do
      r = Recipe.new(name: "Tofu", duration_in_minutes: nil)

      expect(r).not_to be_valid
      expect(r.errors.full_messages).to include("Duration in minutes can't be blank")
    end

    it "validates numericality of duration_in_minutes" do
      r = Recipe.new(name: "Tofu", duration_in_minutes: "asdf")

      expect(r).not_to be_valid
      expect(r.errors.full_messages).to include("Duration in minutes is not a number")
    end

    it "validates non-zero duration_in_minutes" do
      r = Recipe.new(name: "Tofu", duration_in_minutes: 0)

      expect(r).not_to be_valid
      expect(r.errors.full_messages).to include("Duration in minutes must be greater than 0")
    end

    it "validates non-negative duration_in_minutes" do
      r = Recipe.new(name: "Tofu", duration_in_minutes: -43)

      expect(r).not_to be_valid
      expect(r.errors.full_messages).to include("Duration in minutes must be greater than 0")
    end

    it "validates presence of category" do
      r = Recipe.new

      expect(r).not_to be_valid

      expect(r.errors[:category]).to include("must exist")
    end
  end

  describe "#short_to_make" do
    it "returns recipes with 30 minutes or more duration_in_minutes" do
      r_1 = Recipe.create!(name: "asdfasdf", duration_in_minutes: 29, category: category)
      r_2 = Recipe.create!(name: "asdfasdf", duration_in_minutes: 30, category: category)
      r_3 = Recipe.create!(name: "asdfasdf", duration_in_minutes: 31, category: category)

      result = Recipe.short_to_make

      expect(result).to include(r_1)
      expect(result).to include(r_2)
      expect(result).not_to include(r_3)
    end
  end

  describe "#long_to_make" do
    it "returns recipes with 30 minutes or less duration_in_minutes" do
      r_1 = Recipe.create!(name: "asdfasdf", duration_in_minutes: 29, category: category)
      r_2 = Recipe.create!(name: "asdfasdf", duration_in_minutes: 30, category: category)
      r_3 = Recipe.create!(name: "asdfasdf", duration_in_minutes: 31, category: category)

      result = Recipe.long_to_make

      expect(result).not_to include(r_1)
      expect(result).to include(r_2)
      expect(result).to include(r_3)
    end
  end
end
