# == Schema Information
#
# Table name: recipes
#
#  id                  :bigint           not null, primary key
#  duration_in_minutes :integer          default(30), not null
#  name                :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
require "test_helper"

class RecipeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
