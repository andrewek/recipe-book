module Types
  class MutationType < Types::BaseObject
    field :create_author, mutation: Mutations::Authors::Create
    field :update_author, mutation: Mutations::Authors::Update
    field :delete_author, mutation: Mutations::Authors::Delete

    field :create_recipe, mutation: Mutations::Recipes::Create
    field :update_recipe, mutation: Mutations::Recipes::Update
    
    field :create_review, mutation: Mutations::Reviews::Create
    field :update_review, mutation: Mutations::Reviews::Update

    field :create_kitchen, mutation: Mutations::Kitchens::Create
    field :update_kitchen, mutation: Mutations::Kitchens::Update
    field :delete_kitchen, mutation: Mutations::Kitchens::Delete
  end
end
