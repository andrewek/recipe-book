# frozen_string_literal: true

module Types
  module Recipes
    class RecipeType < Types::BaseObject
      description "A recipe for the cooking"

      field :id, ID, null: false
      field :name, String
      field :created_at, GraphQL::Types::ISO8601DateTime, null: false
      field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
      field :duration_in_minutes, Integer, null: false
      field :category_id, Integer
      field :author_id, Integer

      field :author, Types::Authors::AuthorType
      field :category, CategoryType
      field :reviews, [Types::Reviews::ReviewType]
    end
  end
end