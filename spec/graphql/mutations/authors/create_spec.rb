require "rails_helper"

RSpec.describe Mutations::Authors::Create do
  it "creates with good data" do
    query_string = <<~QUERY
      mutation($name: String!) { createAuthor(input: { params: {name: $name}}) {
        author { name id }
      }}
    QUERY

    result = RecipeBookSchema.execute(
      query_string, 
      variables: {name: "Guy Fieri"}, 
      context: {}
    )

    id = result.to_h.dig("data", "createAuthor", "author", "id")

    author = Author.find(id)

    expect(author.name).to eq("Guy Fieri")
  end

  it "fails with bad data" do
    query_string = <<~QUERY
      mutation($name: String!) { createAuthor(input: { params: {name: $name}}) {
        author { name id }
      }}
    QUERY

    result = RecipeBookSchema.execute(
      query_string, 
      variables: {name: "G"}, 
      context: {}
    )

    id = result.to_h.dig("data", "createAuthor", "author", "id")
    expect(id).to be_nil

    error_string = result.to_h["errors"].first["message"]

    expect(error_string).to include("Name is too short (minimum is 2 characters)")
  end
end