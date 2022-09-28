class CreateTags < ActiveRecord::Migration[7.0]
  def change
    create_table :tags do |t|
      t.belongs_to :recipe

      t.string :name, null: false

      t.timestamps
    end
  end
end
