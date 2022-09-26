class CreateReviewsTable < ActiveRecord::Migration[7.0]
  def change
    create_table :reviews do |t|
      t.belongs_to :author
      t.belongs_to :recipe

      t.integer :rating, default: 5, null: false
      t.text :body, default: ""

      t.timestamps
    end
  end
end
