FactoryBot.define do
  factory :idea do
    title {Faker::FunnyName.name}
    description {Faker::Lorem.paragraph}
    association :user, factory: :user
  end
end
