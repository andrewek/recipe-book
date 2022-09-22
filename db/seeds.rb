salad = Category.create!(name: "Salads")
pasta = Category.create!(name: "Pastas")
dessert = Category.create!(name: "Desserts")

Recipe.create!(name: "Caesar Salad", duration_in_minutes: 20, category_id: salad.id)
Recipe.create!(name: "Spaghetti", duration_in_minutes: 45, category_id: pasta.id)
Recipe.create!(name: "Torte", duration_in_minutes: 90, category_id: dessert.id)