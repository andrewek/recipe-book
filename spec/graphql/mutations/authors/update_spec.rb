require "rails_helper"

RSpec.describe Mutations::Authors::Update do
  let(:author) { create(:author) }

  let(:query_string) do
    <<~QUERY
      mutation($id: ID!, $name: String) {
        updateAuthor(input: {
          id: $id, 
          params: {name: $name}
        }) {
          author {name id}
          success
          errors { message attribute }
        }
      }
    QUERY
  end

  it "updates successfully" do
    result = exec_graphql(
      query_string,
      variables: {id: author.id, name: "Chicken Little" }
    )

    expect(result.dig(:data, :updateAuthor, :success)).to eq(true)
    expect(result.dig(:data, :updateAuthor, :errors)).to be_empty
    expect(result.dig(:data, :updateAuthor, :author, :name)).to eq("Chicken Little")

    author.reload

    expect(author.name).to eq("Chicken Little")
  end

  it "fails to update with bad params" do
    result = exec_graphql(
      query_string,
      variables: {id: author.id, name: "C" }
    )

    author.reload
    expect(author.name).not_to eq("C")

    expect(result.dig(:data, :updateAuthor, :success)).to eq(false)
    expect(result.dig(:data, :updateAuthor, :author)).to be_nil

    errors = result.dig(:data, :updateAuthor, :errors)
    expect(errors).not_to be_empty

    expect(errors).to include({
      message: "is too short (minimum is 2 characters)", 
      attribute: "name"
    })
  end

  it "fails to update with no author" do
    result = exec_graphql(
      query_string,
      variables: {id: 0, name: "Chicken Little" }
    )

    expect(result.dig(:data, :updateAuthor, :success)).to eq(false)
    expect(result.dig(:data, :updateAuthor, :author)).to be_nil

    errors = result.dig(:data, :updateAuthor, :errors)
    expect(errors).not_to be_empty

    expect(errors).to include({
      message: "That author does not exist",
      attribute: nil
    })
  end
end