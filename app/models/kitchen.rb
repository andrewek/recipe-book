# == Schema Information
#
# Table name: kitchens
#
#  id         :bigint           not null, primary key
#  location   :string
#  name       :string           not null
#  value      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  author_id  :bigint
#
# Indexes
#
#  index_kitchens_on_author_id  (author_id)
#
class Kitchen < ApplicationRecord
  # Validations
  validates :name, length: { minimum: 2 }
  validates :value, numericality: { greater_than_or_equal_to: 0 }

  # Associations
  belongs_to :author

  # Query Scopes
  scope :name_is_like, -> (token) { where("name ilike ?", "%#{token}%") }
  scope :location_is_like, -> (token) { where("location ilike ?", "%#{token}%") }
  scope :valued_more_than, -> (value) { where("value > ? ", value)}
  scope :valued_less_than, -> (value) { where("value < ? ", value)}
end
