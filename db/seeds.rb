# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


50.times do
  Cat.create!(name: Faker::Name.first_name, sex:['M', 'F'].sample,
              color: [:black, :white, :orange].sample,
              birth_date: Faker::Date.between(10.years.ago, 1.day.ago),
              description: Faker::ChuckNorris.fact)
end
