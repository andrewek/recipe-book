class Resolvers::Reviews::Get < Resolvers::BaseResolver
  type Types::Reviews::ReviewType, null: false
  description "Get a review by ID"

  argument :id, ID

  def resolve(id:)
    Review.find(id)
  end
end