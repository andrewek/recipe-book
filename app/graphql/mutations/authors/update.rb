  class Mutations::Authors::Update < Mutations::BaseMutation
  argument :id, ID
  argument :params, Types::Authors::AuthorUpdateInputType, required: true

  field :author, Types::Authors::AuthorType

  def resolve(id:, params:)
    author_params = params.to_h
    author = Author.find(id)

    if author.update(author_params)
      {author: author}
    else
      GraphQL::ExecutionError.new(
        "Invalid attributes for Author: #{author.errors.full_messages.join(', ')}"
      )
    end
  end
end