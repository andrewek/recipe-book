FactoryBot.define do
  factory :category do
    name { SecureRandom.uuid }
  end
end