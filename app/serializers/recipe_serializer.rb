class RecipeSerializer < ActiveModel::Serializer
  attributes :id, :name, :duration_in_minutes, :author, :category
  has_many :tags

  def author
    object&.author&.name
  end
  
  def category
    object&.category&.name
  end
end
