class Resolvers::Kitchens::Get < Resolvers::BaseResolver
  type Types::Kitchens::KitchenType, null: false
  description "Get one kitchen by ID"

  argument :id, ID

  def resolve(id:)
    Kitchen.find(id)
  end
end