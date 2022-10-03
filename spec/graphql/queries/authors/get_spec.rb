require "rails_helper"

RSpec.describe Resolvers::Authors::Get do
  it "gets an author" do
    query_string = <<~QUERY
      query($id: ID!) { author(id: $id) {
        name id
      }}
    QUERY

    author = create(:author)

    result = RecipeBookSchema.execute(
      query_string,
      variables: {id: author.id},
      context: {}
    )

    author_data = result.to_h.dig("data", "author")
    
    expect(author_data["id"]).to eq(author.id.to_s)
    expect(author_data["name"]).to eq(author.name)
  end

  it "raises when not found" do
    query_string = <<~QUERY
      query($id: ID!) { author(id: $id) {
        name id
      }}
    QUERY

    expect { RecipeBookSchema.execute(
      query_string,
      variables: {id: 0},
      context: {}
    ) }.to raise_error(ActiveRecord::RecordNotFound)
  end
end