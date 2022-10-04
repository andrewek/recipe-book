  class Mutations::Authors::Update < Mutations::BaseMutation
  argument :id, ID
  argument :params, Types::Authors::AuthorUpdateInputType, required: true

  field :author, Types::Authors::AuthorType
  field :success, Boolean
  field :errors, [Types::UserError], null: false

  def resolve(id:, params:)
    author_params = params.to_h
    author = Author.find_by(id: id)

    if author && author.update(author_params)
      {author: author, success: true, errors: []}
    elsif author # Update failed
      errors = author.errors.map do |err|
        {
          message: err.message,
          attribute: err.attribute.to_s.camelize(:lower)
        }
      end

      {
        author: nil,
        success: false,
        errors: errors
      }
    else # No author found
      {
        author: nil, 
        success: false, 
        errors: [{attribute: nil, message: "That author does not exist"}]
      }
    end
  end
end