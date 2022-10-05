# == Schema Information
#
# Table name: kitchens
#
#  id         :bigint           not null, primary key
#  location   :string
#  name       :string           not null
#  value      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  author_id  :bigint
#
# Indexes
#
#  index_kitchens_on_author_id  (author_id)
#
require 'rails_helper'

RSpec.describe Kitchen, type: :model do
  describe "#valid?" do
    it "checks presence of name" do
      kitchen = build(:kitchen, name: nil)

      expect(kitchen).not_to be_valid
      expect(kitchen.errors.full_messages).to include("Name is too short (minimum is 2 characters)")
    end

    it "validates length of name" do
      kitchen = build(:kitchen, name: "Z")

      expect(kitchen).not_to be_valid
      expect(kitchen.errors.full_messages).to include("Name is too short (minimum is 2 characters)")
    end

    it "requires author association" do
      kitchen = build(:kitchen, author: nil)

      expect(kitchen).not_to be_valid
      expect(kitchen.errors[:author]).to include("must exist")
    end
    
    it "requires numeric value" do
      kitchen = build(:kitchen, value: "Bobby's Burger Palace")
      
      expect(kitchen).not_to be_valid
      expect(kitchen.errors[:value]).to include("is not a number")
    end

    it "disallows values less than 0" do
      kitchen = build(:kitchen, value: -1)

      expect(kitchen).not_to be_valid
      expect(kitchen.errors[:value]).to include("must be greater than or equal to 0")
    end
  end
  
  describe "scopes" do
    describe "#name_is_like" do
      it "searches" do
        k_1 = create(:kitchen, name: "East")
        k_2 = create(:kitchen, name: "West")
        k_3 = create(:kitchen, name: "Northeast")

        result = Kitchen.name_is_like("east")
        
        expect(result).to include(k_1)
        expect(result).not_to include(k_2)
        expect(result).to include(k_1)
      end
    end
    
    describe "#location_is_like" do
      it "searches" do
        k_1 = create(:kitchen, location: "East")
        k_2 = create(:kitchen, location: "West")
        k_3 = create(:kitchen, location: "Northeast")

        result = Kitchen.location_is_like("east")
        
        expect(result).to include(k_1)
        expect(result).not_to include(k_2)
        expect(result).to include(k_1)
      end
    end
    
    describe "#valued_more_than" do
      it "returns the correct results" do
        k_1 = create(:kitchen, value: 563_312)
        k_2 = create(:kitchen, value: 761_856)
        k_3 = create(:kitchen, value: 214_444)

        result = Kitchen.valued_more_than(500_000)
        
        expect(result).to include(k_1)
        expect(result).to include(k_2)
        expect(result).not_to include(k_3)
      end
    end
    
    describe "#valued_less_than" do
      it "returns the correct results" do
        k_1 = create(:kitchen, value: 563_312)
        k_2 = create(:kitchen, value: 761_856)
        k_3 = create(:kitchen, value: 214_444)

        result = Kitchen.valued_less_than(500_000)
        
        expect(result).not_to include(k_1)
        expect(result).not_to include(k_2)
        expect(result).to include(k_3)
      end 
    end
  end
end
