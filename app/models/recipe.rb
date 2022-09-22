# name
# id
# created_at
# updated_at
class Recipe < ApplicationRecord
  validates :name, length: { minimum: 2 }
end
