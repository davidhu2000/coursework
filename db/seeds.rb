# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

5.times do
  User.create!(username: Faker::Name.name)
end

5.times do |i|
  3.times do
    Contact.create!(name: Faker::Name.name, email: Faker::Internet.email, user_id: i)
  end
end

5.times do |i|
  ContactShare.create!(user_id: i+1, contact_id: i == 4 ? 1 : i + 2)
end

5.times do |i|
  Comment.create!(body: Faker::ChuckNorris.fact, comments_id: i + 1, comments_type: 'User')
end

15.times do |i|
  Comment.create!(body: Faker::ChuckNorris.fact, comments_id: i + 1, comments_type: 'Contact')
end
