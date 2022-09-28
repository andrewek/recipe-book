class AddTagsCategoryToRecipes < ActiveRecord::Migration[7.0]
  def change
    change_table :recipes do |t|
      t.belongs_to :tags
    end
  end
end
