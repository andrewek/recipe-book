# == Schema Information
#
# Table name: tags
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Tag < ApplicationRecord
  # Validations
  validates :name, length: { minimum: 2 }

  # Associations
  has_and_belongs_to_many :recipes

  # Query Scopes
  scope :name_is_like, -> (token) { where("name ilike ?", "%#{token}%") }
    # Allows expansive searches of recipes by tag.
end
