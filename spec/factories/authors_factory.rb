FactoryBot.define do
  factory :author do
    name { SecureRandom.uuid }
  end
end