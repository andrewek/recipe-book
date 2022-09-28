salad = Category.create!(name: "Salads")
pasta = Category.create!(name: "Pastas")
dessert = Category.create!(name: "Desserts")

julia = Author.create!(name: "Julia Turshen")
angela = Author.create!(name: "Angela Garbacz")

Recipe.create!(name: "Caesar Salad", duration_in_minutes: 20, category_id: salad.id, author_id: julia.id)
Recipe.create!(name: "Spaghetti", duration_in_minutes: 45, category_id: pasta.id, author_id: julia.id)
Recipe.create!(name: "Torte", duration_in_minutes: 90, category_id: dessert.id, author_id: angela.id)

comfort = Tag.create!(name: "comfort food")
fancy = Tag.create!(name: "fine dining")
easy = Tag.create!(name: "easy to make")