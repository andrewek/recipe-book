class Resolvers::Kitchens::All < Resolvers::BaseResolver
  type [Types::Kitchens::KitchenType], null: false
  description "Get all kitchens"

  argument :name_like, String, required: false 
  argument :location_like, String, required: false
  argument :valued_over, String, required: false
  argument :valued_under, String, required: false

  def resolve(**args)
    KitchensSearch.new(args).call
  end
end