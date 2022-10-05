FactoryBot.define do
  factory :tag do
    name { SecureRandom.uuid }
  end
end