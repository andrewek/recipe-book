class Types::Reviews::ReviewUpdateInputType < Types::BaseInputObject
  argument :rating, Integer, required: false
  argument :body, String, required: false
end