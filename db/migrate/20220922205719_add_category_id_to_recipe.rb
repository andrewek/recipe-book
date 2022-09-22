class AddCategoryIdToRecipe < ActiveRecord::Migration[7.0]
  def change
    change_table :recipes do |t|
      t.belongs_to :category
    end
  end
end
