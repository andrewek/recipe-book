class AddAuthorAssociationToRecipes < ActiveRecord::Migration[7.0]
  def change
    change_table :recipes do |t|
      t.belongs_to :author
    end
  end
end
