# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(username: "rob", password: "app")
User.create!(username: "kelly", password: "app")

98.times do
  Cat.create!(name: Faker::Name.name, color: 'black', birth_date: '2016/1/1',
    user_id: 1, description: Faker::ChuckNorris.fact, sex: 'F')
end

Cat.create!(name: Faker::Name.name, color: 'black', birth_date: '2016/1/1',
  user_id: 2, description: Faker::ChuckNorris.fact, sex: 'F')
