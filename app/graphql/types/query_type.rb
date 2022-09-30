module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    field :recipe, RecipeType, "Find recipe by ID" do
      argument :id, ID
    end

    field :recipes, [RecipeType], "All recipes" do
      argument :name_like, String, required: false
      argument :duration_under, Integer, required: false
      argument :duration_over, Integer, required: false
      argument :author_id, [Integer], required: false
    end

    def recipe(id:)
      Recipe.find(id)
    end

    def recipes(**args)
      RecipesSearch.new(args).call
    end
  end
end
