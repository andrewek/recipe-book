class Resolvers::Recipes::Get < Resolvers::BaseResolver
  type Types::Recipes::RecipeType, null: false
  description "Get one recipe by ID"
  
  argument :id, ID

  def resolve(id:)
    Recipe.find(id)
  end
end