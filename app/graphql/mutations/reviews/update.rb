class Mutations::Reviews::Update < Mutations::BaseMutation
  argument :id, ID
  argument :params, Types::Reviews::ReviewUpdateInputType, required: true

  field :review, Types::Reviews::ReviewType

  def resolve(id:, params:)
    review_params = params.to_h
    review = Review.find(id)

    if review.update(review_params)
      { review: review }
    else
      GraphQL::ExecutionError.new(
        "Invalid attributes for Review: #{review.errors.full_messages.join(', ')}"
      )
    end
  end
end