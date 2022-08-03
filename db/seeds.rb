# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Review.destroy_all
Idea.destroy_all
User.destroy_all

10.times do 
    first_name = Faker::Name.first_name
    last_name = Faker::Name.last_name
    User.create(
        name: first_name + " " + last_name,
        email: "#{first_name}@#{last_name}.com",
        password: "123"
    )
end
  
users = User.all

50.times do
    i = Idea.create(
        title: Faker::FunnyName.name,
        description: Faker::Lorem.paragraph,
        user: users.sample
    )
    if i.valid?
        rand(1..5).times do
            Review.create(body: Faker::Hacker.say_something_smart, idea:i, user: users.sample)
        end
    end
end