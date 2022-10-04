class CreateKitchens < ActiveRecord::Migration[7.0]
  def change
    create_table :kitchens do |t|
      t.belongs_to :author

      t.string :name, null: false
      t.string :location, default: ""
      t.integer :value, default: 0

      t.timestamps
    end
  end
end
