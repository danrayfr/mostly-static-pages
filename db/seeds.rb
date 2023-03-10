# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Create a main sample user with admin role. 
User.create!(name: "Dan Ray Rollan", 
              email: "danrayrollan98@gmail.com", 
              password: "password", 
              password_confirmation: "password", 
              admin: true,
              activated: true, 
              activated_at: Time.zone.now
            )
User.create!(name: "Admin User", 
              email: "user@admin.com", 
              password: "password", 
              password_confirmation: "password", 
              admin: true,
              activated: true, 
              activated_at: Time.zone.now
            )

# Generate a bunch of additional users
100.times do |n|
  name = Faker::Name.name
  email = "user-#{n+1}@example.com"
  password = "password"
  User.create!(name: name, 
                email: email, 
                password: password, 
                password_confirmation: password,
                activated: true,
                activated_at: Time.zone.now
              )
end

# Generate microposts for a subset of users
users = User.order(:created_at).take(6)
50.times do 
  content = Faker::Lorem.sentence(word_count: 10)
  users.each { |user| user.microposts.create!(content: content)}
end

# Create following relationships.
users = User.all
user = users.first
following = users[5..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }

puts "Done seeding the database"