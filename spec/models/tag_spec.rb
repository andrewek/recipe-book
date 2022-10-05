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
  describe "#valid?" do
    it "validates presence of name" do
      tag = build(:tag, name: nil)

      expect(tag).not_to be_valid
      expect(tag.errors[:name]).to include("is too short (minimum is 2 characters)")
    end

    it "validates length of name" do
      tag = build(:tag, name: "a")

      expect(tag).not_to be_valid
      expect(tag.errors[:name]).to include("is too short (minimum is 2 characters)")
    end
  end

  describe "#name_is_like" do
    it "finds tags by name" do
      t_1 = create(:tag, name: "easy to make")
      t_2 = create(:tag, name: "southern style cooking")
      t_3 = create(:tag, name: "hard to make")

      result = Tag.name_is_like("make")

      expect(result).to include(t_1)
      expect(result).to include(t_3)
      expect(result).not_to include (t_2)
    end
  end
end
