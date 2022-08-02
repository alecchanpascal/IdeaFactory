FactoryBot.define do
  factory :idea do
    title {Faker::FunnyName.name}
    description {Faker::Lorem.paragraph}
  end
end
