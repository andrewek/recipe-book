# == Schema Information
#
# Table name: recipes
#
#  id                  :bigint           not null, primary key
#  duration_in_minutes :integer          default(30), not null
#  name                :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  author_id           :bigint
#  category_id         :bigint
#
# Indexes
#
#  index_recipes_on_author_id    (author_id)
#  index_recipes_on_category_id  (category_id)
#
class RecipeSerializer < ActiveModel::Serializer
  attributes :id, :name, :duration_in_minutes, :created_at, :updated_at
  
  has_many :tags
  belongs_to :author
  belongs_to :category
end
