require 'rails_helper'

RSpec.describe Recipe, type: :model do
  it "validates presence of name" do
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

  describe "#short_to_make" do
    it "returns recipes with 30 minutes or more duration_in_minutes" do
      r_1 = Recipe.create!(name: "asdfasdf", duration_in_minutes: 29)
      r_2 = Recipe.create!(name: "asdfasdf", duration_in_minutes: 30)
      r_3 = Recipe.create!(name: "asdfasdf", duration_in_minutes: 31)

      result = Recipe.short_to_make

      expect(result).to include(r_1)
      expect(result).to include(r_2)
      expect(result).not_to include(r_3)
    end
  end

  describe "#long_to_make" do
    it "returns recipes with 30 minutes or less duration_in_minutes" do
      r_1 = Recipe.create!(name: "asdfasdf", duration_in_minutes: 29)
      r_2 = Recipe.create!(name: "asdfasdf", duration_in_minutes: 30)
      r_3 = Recipe.create!(name: "asdfasdf", duration_in_minutes: 31)

      result = Recipe.long_to_make

      expect(result).not_to include(r_1)
      expect(result).to include(r_2)
      expect(result).to include(r_3)
    end
  end
end