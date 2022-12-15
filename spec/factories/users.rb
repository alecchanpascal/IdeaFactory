FactoryBot.define do
  factory :user do
    name{Faker::FunnyName.name}
    sequence(:email){|n| "test#{n}@gmail.com"}
    password{"123"}
  end
end
