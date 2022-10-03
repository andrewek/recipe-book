class Types::Recipes::RecipeUpdateInputType < Types::BaseInputObject
  argument :name, String, required: false
  argument :duration_in_minutes, Integer, required: false
  argument :category_id, Integer, required: false
end