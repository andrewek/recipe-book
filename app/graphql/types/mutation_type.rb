module Types
  class MutationType < Types::BaseObject
    field :create_author, mutation: Mutations::Authors::Create
    field :update_author, mutation: Mutations::Authors::Update


    field :create_recipe, mutation: Mutations::Recipes::Create
    field :update_recipe, mutation: Mutations::Recipes::Update
    
    field :create_review, mutation: Mutations::Reviews::Create
  end
end
