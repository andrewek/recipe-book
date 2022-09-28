class RecipesController < ApplicationController
  # GET /recipes
  def index
    # TODO: Fetch actual recipes
    render json: { data: Recipe.all }
  end

  def show
    id = params[:id]

    @recipe = Recipe.find_by(id: id)

    if @recipe
      render json: { data: @recipe }
    else
      render json: { errors: ["That recipe does not exist"] }, status: :not_found
    end
  end

  def create
    recipe = Recipe.new(recipe_params)

    if recipe.save
      render json: { data: recipe }, status: :created
    else
      render json: {errors: recipe.errors.full_messages}, status: :bad_request
    end
  end

  def recipe_params
    params.require(:recipe).permit(:name, :author_id, :category_id, :duration_in_minutes)
  end
end