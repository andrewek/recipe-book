class Resolvers::Authors::All < Resolvers::BaseResolver
  type [Types::AuthorType], null: false
  description "Get all authors"

  argument :name_like, String, required: false
  argument :reviews_over, Integer, required: false
  argument :reviews_under, Integer, required: false
  argument :recipes_under, Integer, required: false
  argument :recipes_over, Integer, required: false

  def resolve(**args)
    AuthorsSearch.new(args).call
  end
end

