class TagsAndRecipesJoin < ActiveRecord::Migration[7.0]
  def change
    create_table :recipes_tags, id: false do |t|
      t.belongs_to :tag, index: true
      t.belongs_to :recipe, index: true
    end
  end
end
