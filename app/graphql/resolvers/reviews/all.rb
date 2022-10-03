class Resolvers::Reviews::All < Resolvers::BaseResolver
  type [Types::Reviews::ReviewType], null: false
  description "Get all reviews"

  def resolve()
    Review.all()
  end
end