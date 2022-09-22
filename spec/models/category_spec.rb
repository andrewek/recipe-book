require 'rails_helper'

RSpec.describe Category, type: :model do
  describe "#valid?" do
    it "checks presence of name" do
      c = Category.new(name: nil)

      expect(c).not_to be_valid

      expect(c.errors[:name]).to include("is too short (minimum is 2 characters)")
    end

    it "checks length of name" do
      c = Category.new(name: "a")

      expect(c).not_to be_valid

      expect(c.errors[:name]).to include("is too short (minimum is 2 characters)")
    end
  end
end
