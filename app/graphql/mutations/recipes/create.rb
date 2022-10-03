class Mutations::Recipes::Create < Mutations::BaseMutation
  argument :params, Types::Recipes::RecipeInputType, required: true

  field :recipe, Types::Recipes::RecipeType

  def resolve(params:)
    params = params.to_h

    recipe = Recipe.new(params)

    if recipe.save
      {recipe: recipe}
    else
      GraphQL::ExecutionError.new("Invalid attributes for Recipe: #{recipe.errors.full_messages.join(', ')}")
    end
  end
end