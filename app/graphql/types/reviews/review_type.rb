# frozen_string_literal: true

class Types::Reviews::ReviewType < Types::BaseObject
  field :id, ID, null: false
  field :author_id, Integer
  field :recipe_id, Integer
  field :rating, Integer, null: false
  field :body, String
  field :created_at, GraphQL::Types::ISO8601DateTime, null: false
  field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

  field :recipe, Types::Recipes::RecipeType
  field :author, Types::Authors::AuthorType
end
