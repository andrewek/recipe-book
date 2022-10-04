require "rails_helper"

RSpec.describe Mutations::Authors::Delete do
  let(:author) { create(:author) }

  let(:query_string) do
    <<~QUERY
      mutation($id: ID!) {
        deleteAuthor(input: {id: $id}) {
          message success 
        }
      }
    QUERY
  end

  it "deletes an existing author" do
    result = exec_graphql(
      query_string,
      variables: {id: author.id},
      context: {current_author: author}
    )

    expect(result.dig(:data, :deleteAuthor, :success)).to be true
    expect(Author.find_by(id: author.id)).to be_nil
  end

  it "destroys an author with their recipes" do
    _recipes = create_list(:recipe, 5, author: author)

    result = exec_graphql(
      query_string,
      variables: {id: author.id},
      context: {current_author: author}
    )

    expect(result.dig(:data, :deleteAuthor, :success)).to be true
    expect(Recipe.where(author: author)).to be_empty
  end

  it "destroys an author with their reviews but not the reviewed recipes" do
    recipe = create(:recipe, author: create(:author))
    review = create(:review, author: author, recipe: recipe)

    result = exec_graphql(
      query_string,
      variables: {id: author.id},
      context: {current_author: author}
    )
    
    expect(result.dig(:data, :deleteAuthor, :success)).to be true
    expect(Review.find_by(id: review.id)).to be_nil
    expect(Recipe.find_by(id: recipe.id)).to be_present
  end

  it "returns an error? if the author doesn't exist" do
    result = exec_graphql(
      query_string,
      variables: {id: 0},
      context: {current_author: author}
    )

    expect(result.dig(:data, :deleteAuthor, :success)).to be false
    expect(result.dig(:data, :deleteAuthor, :message)).to eq(
      "That author doesn't exist or you're not allowed to do that"
    )
  end

  it "returns an error if the author mismatches" do
    second_author = create(:author)
    
    result = exec_graphql(
      query_string,
      variables: {id: second_author.id},
      context: {current_author: author}
    )

    expect(result.dig(:data, :deleteAuthor, :success)).to be false
    expect(result.dig(:data, :deleteAuthor, :message)).to eq(
      "That author doesn't exist or you're not allowed to do that"
    )
  end
end