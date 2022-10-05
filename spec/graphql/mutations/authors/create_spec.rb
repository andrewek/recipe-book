require "rails_helper"

RSpec.describe Mutations::Authors::Create do
  let(:query_string) do
    <<~QUERY
      mutation($name: String!) { 
        createAuthor(input: { params: {name: $name}}) {
          author { name id }
        }
      }
    QUERY
  end

  it "creates with good data" do
    attrs = attributes_for(:author)
    
    result = exec_graphql(
      query_string, 
      variables: attrs
    )

    id = result.dig(:data, :createAuthor, :author, :id)

    author = Author.find(id)

    expect(author.name).to eq(attrs[:name])
  end

  it "fails with bad data" do
    result = exec_graphql(
      query_string, 
      variables: {name: "G"}, 
    )

    id = result.dig(:data, :createAuthor, :author, :id)
    expect(id).to be_nil

    error_string = result[:errors].first[:message]

    expect(error_string).to include("Name is too short (minimum is 2 characters)")
  end
end