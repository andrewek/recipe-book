# frozen_string_literal: true

class Types::Authors::AuthorType < Types::BaseObject
  field :id, ID, null: false
  field :name, String
  field :created_at, GraphQL::Types::ISO8601DateTime, null: false
  field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  field :joined_at, String
  
  field :recipes, [Types::Recipes::RecipeType]
  field :reviews, [Types::ReviewType]

  def joined_at
    object.created_at
  end
end
