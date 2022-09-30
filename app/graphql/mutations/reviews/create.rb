class Mutations::Reviews::Create < Mutations::BaseMutation
  argument :params, Types::ReviewInputType, required: true

  field :review, Types::ReviewType

  def resolve(params:)
    params = params.to_h

    review = Review.new(params)

    if review.save
      { review: review }
    else
      GraphQL::ExecutionError.new(
        "Invalid attributes for Review: #{review.errors.full_messages.join(', ')}"
      )
    end
  end
end