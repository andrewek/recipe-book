FactoryBot.define do
  factory :review do
    author
    recipe
    rating { rand(0..5) }
    body { "this needs to be more grilled for me and my foremen" }
  end
end