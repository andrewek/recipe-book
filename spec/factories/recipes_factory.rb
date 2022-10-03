FactoryBot.define do
  factory :recipe do
    author
    category
    name { SecureRandom.uuid }
    duration_in_minutes { rand(1..200) }
  end
end