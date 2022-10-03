class Mutations::Authors::Delete < Mutations::BaseMutation
  argument :id, ID, required: true

  field :message, String
  field :success, Boolean

  def resolve(id:)
    author = Author.find(id)

    if author.destroy
      {
        success: true,
        message: "That author is gone!"
      }
    else
      {success: false, message: "?????"}
    end
  end
end