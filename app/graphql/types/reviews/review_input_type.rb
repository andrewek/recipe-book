class Types::Reviews::ReviewInputType < Types::BaseInputObject
  argument :rating, Integer, required: true
  argument :body, String, required: false
  argument :author_id, Integer, required: true
  argument :recipe_id, Integer, required: true
end