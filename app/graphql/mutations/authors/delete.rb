class Mutations::Authors::Delete < Mutations::BaseMutation
  argument :id, ID, required: true

  field :message, String
  field :success, Boolean

  def resolve(id:)
    author = Author.find_by(id: id)

    if can_destroy?(author) && author.destroy
      {
        success: true,
        message: "That author is gone!"
      }
    else
      {
        success: false, 
        message: "That author doesn't exist or you're not allowed to do that" 
      }
    end
  end

  private

  def can_destroy?(author)
    author && context[:current_author] == author
  end
end