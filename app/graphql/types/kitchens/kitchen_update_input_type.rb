class Types::Kitchens::KitchenUpdateInputType < Types::BaseInputObject
  argument :name, String, required: false
  argument :value, Integer, required: false
  argument :location, String, required: false
end