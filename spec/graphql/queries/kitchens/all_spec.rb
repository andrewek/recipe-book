require "rails_helper"

RSpec.describe Resolvers::Kitchens::All do
  it "gets all kitchens" do
    query_string = <<~QUERY
      query { kitchens { name id } }
    QUERY

    kitchens = create_list(:kitchen, 4)

    result = RecipeBookSchema.execute(
      query_string,
      variables: {},
      context: {}
    )

    kitchens_json = result.to_h.dig("data", "kitchens")
    expect(kitchens_json.length).to eq(kitchens.length)

    kitchens.each do |kitchen|
      expect(kitchens_json.find do |item|
        item["id"].to_i == kitchen.id
      end).to be_present
    end
  end
end