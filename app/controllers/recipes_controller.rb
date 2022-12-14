class RecipesController < ApplicationController
  skip_before_action :current_author
  
  # GET /recipes
  def index
    recipes = RecipesSearch.new(params.to_unsafe_h).call

    ok(recipes)
  end

  def show
    id = params[:id]

    @recipe = Recipe.find_by(id: id)

    if @recipe
      ok(@recipe)
    else
      render json: { errors: ["That recipe does not exist"] }, status: :not_found
    end
  end

  def create
    recipe = Recipe.new(create_params)

    if recipe.save
      created(recipe)
    else
      render json: {errors: recipe.errors.full_messages}, status: :bad_request
    end
  end

  def update
    @recipe = Recipe.find_by(id: params[:id])

    if @recipe
      if @recipe.update(update_params)
        ok(@recipe)
      else
        render json: {errors: recipe.errors.full_messages}, status: :bad_request
      end
    else
      render json: { errors: ["Cannot update, recipe does not exist"] }, status: :not_found
    end
  end

  def destroy
    @recipe = Recipe.find_by(id: params[:id])

    if @recipe
      if @recipe.destroy
        deleted(@recipe)
        #render json: { data: @recipe, message: "Deletion successful." }, status: 200
      else
        render json: {errors: recipe.errors.full_messages}, status: :bad_request
      end
    else
      render json: { errors: ["Cannot delete, recipe does not exist"] }, status: :not_found
    end
  end

  private

  def create_params
    params.require(:recipe).permit(:name, :author_id, :category_id, :duration_in_minutes)
  end

  def update_params
    params.require(:recipe).permit(:name, :category_id, :duration_in_minutes)
  end
end