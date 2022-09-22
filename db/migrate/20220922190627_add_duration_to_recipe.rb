class AddDurationToRecipe < ActiveRecord::Migration[7.0]
  def change
    add_column :recipes, :duration_in_minutes, :integer, null: false, default: 30
  end
end
