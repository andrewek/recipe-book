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
  describe "#valid?" do
    it "validates presence of name" do
      a = Author.new(name: nil)

      expect(a).not_to be_valid
      expect(a.errors.full_messages).to include("Name is too short (minimum is 2 characters)")
    end

    it "validates length of name" do
      a = Author.new(name: "a")

      expect(a).not_to be_valid
      expect(a.errors.full_messages).to include("Name is too short (minimum is 2 characters)")
    end
  end

  describe "scopes" do
    describe "#search_all_authors" do
      it "searches" do
        a_1 = create(:author, name: "Keira Knightley")
        a_2 = create(:author, name: "Jane Austen")
        a_3 = create(:author, name: "Elizabeth Bennett")

        result = Author.search_all_authors("Jane")
        
        expect(result).to include(a_2)
        expect(result).not_to include(a_1)
        expect(result).not_to include(a_3)
      end
    end

    describe "#oldest_recipe" do
      it "retrieves oldest recipe" do
        a = create(:author, name: "Keira Knightley")

        r_1 = create(:recipe, author: a, created_at: 1.month.ago)
        r_2 = create(:recipe, author: a, created_at: 2.days.ago)
        r_3 = create(:recipe, author: a, created_at: 2.months.ago)

        result = a.oldest_recipe

        expect(r_3).to eq result
      end
    end

    describe "#newest_recipe" do
      it "retrieves newest recipe" do
        a = create(:author, name: "Keira Knightley")

        r_1 = create(:recipe, author: a, created_at: 1.month.ago)
        r_2 = create(:recipe, author: a, created_at: 2.days.ago)
        r_3 = create(:recipe, author: a, created_at: 2.months.ago)

        result = a.newest_recipe

        expect(r_2).to eq result
      end
    end
  end
end