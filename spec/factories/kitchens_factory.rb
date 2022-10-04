FactoryBot.define do
  factory :kitchen do
    name { SecureRandom.uuid }
    location { SecureRandom.uuid }
    value { rand(1..5_000) }
    author
  end
end
