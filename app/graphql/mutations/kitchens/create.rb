class Mutations::Kitchens::Create < Mutations::BaseMutation
  argument :params, Types::Kitchens::KitchenInputType, required: true

  field :kitchen, Types::Kitchens::KitchenType

  def resolve(params:)
    params = params.to_h
    
    kitchen = Kitchen.new(params)

    if kitchen.save
      {kitchen: kitchen}
    else
      GraphQL::ExecutionError.new("Invalid attributes for Kitchen: #{kitchen.errors.full_messages.join(', ')}")
    end
  end
end