# == Schema Information
#
# Table name: authors
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class AuthorSerializer < ActiveModel::Serializer
  attributes :id, :name, :created_at, :updated_at

  has_many :reviews
  has_many :recipes
end
