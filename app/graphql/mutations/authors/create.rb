class Mutations::Authors::Create < Mutations::BaseMutation
  argument :params, Types::Authors::AuthorInputType, required: true

  field :author, Types::Authors::AuthorType

  def resolve(params:)
    params = params.to_h
    
    author = Author.new(params)

    if author.save
      {author: author}
    else
      GraphQL::ExecutionError.new("Invalid attributes for Author: #{author.errors.full_messages.join(', ')}")
    end
  end
end