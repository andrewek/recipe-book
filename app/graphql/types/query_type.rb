module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    field :recipe, resolver: Resolvers::Recipes::Get
    field :recipes, resolver: Resolvers::Recipes::All
    
    field :author, resolver: Resolvers::Authors::Get
    field :authors, resolver: Resolvers::Authors::All

    
  end
end
