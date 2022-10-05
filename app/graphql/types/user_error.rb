class Types::UserError < Types::BaseObject
  description "A user-readable error"

  field :message, String, null: false,
    description: "A description of the error"
  field :attribute, String, null: true, description: "Attribute name"
end