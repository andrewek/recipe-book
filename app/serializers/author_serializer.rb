class AuthorSerializer < ActiveModel::Serializer
  attributes :id, :name, :created_at, :updated_at

  has_many :reviews
  has_many :recipes
end
