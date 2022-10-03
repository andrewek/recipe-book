require "rails_helper"

RSpec.describe Mutations::Recipes::Create do
  let(:author) { create(:author) }
  let(:category) { create(:category) }
  let(:query_string) do
    <<~QUERY
      mutation($name: String!, $durationInMinutes: Int!, $authorId: Int!, $categoryId: Int!) { createRecipe(input: { params: {
        name: $name,
        durationInMinutes: $durationInMinutes,
        authorId: $authorId,
        categoryId: $categoryId
      }}) {
        recipe { name id durationInMinutes author { name id } category {name id}}
      }}
    QUERY
  end

  it "creates" do
    result = exec_graphql(
      query_string, 
      variables: {
        name: "Flaming tacos on a flip-flop",
        durationInMinutes: 90,
        authorId: author.id,
        categoryId: category.id
      }
    )

    id = result.dig(:data, :createRecipe, :recipe, :id)

    recipe = Recipe.find(id)

    expect(recipe.author_id).to eq(author.id)
    expect(recipe.category_id).to eq(category.id)
    expect(recipe.duration_in_minutes).to eq(90)
    expect(recipe.name).to eq("Flaming tacos on a flip-flop")
  end
end