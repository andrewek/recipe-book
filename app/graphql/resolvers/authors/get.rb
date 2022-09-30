class Resolvers::Authors::Get < Resolvers::BaseResolver
  type Types::AuthorType, null: false
  description "Get one author by ID"

  argument :id, ID

  def resolve(id:)
    Author.find(id)
  end
end