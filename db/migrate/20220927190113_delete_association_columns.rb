class DeleteAssociationColumns < ActiveRecord::Migration[7.0]
  def change
    remove_column :recipes, :tags_id
    remove_column :tags, :recipe_id
  end
end
