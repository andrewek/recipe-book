FactoryBot.define do
  factory :tag do
    recipes { [FactoryBot.create(:recipe)] }
    name { SecureRandom.uuid }
  end
end