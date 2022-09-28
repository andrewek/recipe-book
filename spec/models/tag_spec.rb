# == Schema Information
#
# Table name: tags
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Tag, type: :model do
  let(:author) { Author.create!(name: "Gordon Ramsay") }
  let(:category) { Category.create!(name: "Fancy Food") }
  let(:recipe) do
    Recipe.create!(
      name: "Filet Mignon",
      author: author,
      duration_in_minutes: 120,
      category: category
    )
  end
  let(:tag) { Tag.new(name: "comfort food") }

  describe "#valid?" do
    it "validates presence of name" do
      tag.name = nil

      expect(tag).not_to be_valid
      expect(tag.errors[:name]).to include("is too short (minimum is 2 characters)")
    end

    it "validates length of name" do
      tag.name = "a"

      expect(tag).not_to be_valid
      expect(tag.errors[:name]).to include("is too short (minimum is 2 characters)")
    end

    it "allows lacking recipe association" do
      tag.recipes = []
      
      expect(tag).to be_valid
    end
  end

  describe "#name_is_like" do
    it "finds tags by name" do
      t_1 = Tag.create!(name: "easy to make")
      t_2 = Tag.create!(name: "southern style cooking")
      t_3 = Tag.create!(name: "hard to make")

      result = Tag.name_is_like("make")

      expect(result).to include(t_1)
      expect(result).to include(t_3)
      expect(result).not_to include (t_2)
    end
  end
end
