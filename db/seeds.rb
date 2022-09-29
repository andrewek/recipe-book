salad = Category.create!(name: "Salads")
pasta = Category.create!(name: "Pastas")
dessert = Category.create!(name: "Desserts")

julia = Author.create!(name: "Julia Turshen")
angela = Author.create!(name: "Angela Garbacz")

caesar = Recipe.create!(
  name: "Caesar Salad",
  duration_in_minutes: 20,
  category: salad,
  author: julia
)
spag = Recipe.create!(
  name: "Spaghetti", 
  duration_in_minutes: 45,
  category: pasta,
  author: julia
)
torte = Recipe.create!(
  name: "Torte", 
  duration_in_minutes: 90,
  category: dessert,
  author: angela
)

comfort = Tag.create!(name: "comfort food")
fancy = Tag.create!(name: "fine dining")
easy = Tag.create!(name: "easy to make")

good = Review.create!(
  rating: 4,
  author: julia,
  recipe: caesar
)
bad = Review.create!(
  rating: 1,
  author: angela,
  recipe: caesar
)
okay = Review.create!(
  rating: 3,
  author: julia,
  recipe: spag
)