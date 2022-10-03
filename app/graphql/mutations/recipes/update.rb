class Mutations::Recipes::Update < Mutations::BaseMutation

  argument :id, ID
  argument :params, Types::Recipes::RecipeUpdateInputType, required: true

  field :recipe, Types::Recipes::RecipeType

  def resolve(id:, params:)
    recipe_params = params.to_h

    recipe = Recipe.find(id)

    if recipe.update(recipe_params)
      {recipe: recipe}
    else
      GraphQL::ExecutionError.new(
        "Invalid attributes for Recipe: #{recipe.errors.full_messages.join(', ')}"
      )
    end
  end
end