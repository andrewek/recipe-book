require "rails_helper"

RSpec.describe Resolvers::Authors::All do
  it "gets all authors" do
    query_string = <<~QUERY
      query { authors { name id } }
    QUERY

    authors = create_list(:author, 5)

    result = RecipeBookSchema.execute(
      query_string, 
      variables: {}, 
      context: {}
    )

    authors_json = result.to_h.dig("data", "authors")
    expect(authors_json.length).to eq(authors.length)
    authors.each do |author|
      expect(authors_json.find do |el| 
        el["id"].to_i == author.id
      end).to be_present
    end
  end
end