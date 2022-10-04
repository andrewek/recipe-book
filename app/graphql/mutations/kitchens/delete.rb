class Mutations::Kitchens::Delete < Mutations::BaseMutation
  argument :id, ID, required: true

  field :message, String
  field :success, Boolean

  def resolve(id:)
    kitchen = Kitchen.find_by(id: id)

    if kitchen.destroy
      {
        success: true,
        message: "Bye, Kitchen!"
      }
    else
      {success: false, message: "What happened?"}
    end
  end
end