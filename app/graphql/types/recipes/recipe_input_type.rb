class Types::Recipes::RecipeInputType < Types::BaseInputObject
  argument :name, String, required: true
  argument :duration_in_minutes, Integer, required: true
  argument :author_id, Integer, required: true
  argument :category_id, Integer, required: true
end