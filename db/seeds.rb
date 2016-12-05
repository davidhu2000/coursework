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
  2.times do
    ContactShare.create!(user_id: i, contact_id: ((1..5).to_a - [i+1]).sample)
  end
end
