module Types
  class MutationType < Types::BaseObject
    field :create_author, mutation: Mutations::Authors::Create

    field :create_recipe, mutation: Mutations::Recipes::Create
    
    field :create_review, mutation: Mutations::Reviews::Create
  end
end
