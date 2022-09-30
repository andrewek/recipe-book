class Resolvers::Recipes::All < Resolvers::BaseResolver
  type [Types::RecipeType], null: false
  description "Get all recipes (possibly filtered)"

  argument :name_like, String, required: false
  argument :duration_under, Integer, required: false
  argument :duration_over, Integer, required: false
  argument :author_id, [Integer], required: false

  def resolve(**args)
    RecipesSearch.new(args).call
  end
end