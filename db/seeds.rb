# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

10.times do
  User.create!(email: Faker::Internet.email)
end

# 10.times do
#   ShortenUrl.create!(short_url: Faker::Number.number(10), long_url: Faker::Internet.url, owner_id: rand(10) + 1)
# end
ShortenedUrl.create!(short_url: 'abc', long_url: 'facebook.com', owner_id: 1)
ShortenedUrl.create!(short_url: 'def', long_url: 'github.com', owner_id: 2)
