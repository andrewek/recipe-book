class Types::Kitchens::KitchenInputType < Types::BaseInputObject
  argument :name, String, required: true
  argument :value, Integer, required: false
  argument :location, String, required: false
  argument :author_id, Integer, required: true
end