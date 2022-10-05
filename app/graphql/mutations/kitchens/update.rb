class Mutations::Kitchens::Update < Mutations::BaseMutation
  argument :id, ID
  argument :params, Types::Kitchens::KitchenUpdateInputType, required: true

  field :kitchen, Types::Kitchens::KitchenType

  def resolve(id:, params:)
    kitchen_params = params.to_h
    kitchen = Kitchen.find_by(id: id)

    if kitchen&.update(kitchen_params)
      { kitchen: kitchen }
    else
      GraphQL::ExecutionError.new(
        "Invalid attributes for kitchen or nonexistent kitchen: #{kitchen.errors.full_messages.join(', ')}"
      )
    end
  end
end