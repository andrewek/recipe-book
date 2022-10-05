class Types::Kitchens::KitchenType < Types::BaseObject
  field :id, ID, null: false
  field :name, String
  field :location, String
  field :value, Integer
  field :created_at, GraphQL::Types::ISO8601DateTime, null: false
  field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  
  field :author, Types::Authors::AuthorType
end