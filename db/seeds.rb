# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(username: "bob", password: "password")

10.times do
  Sub.create!(title: Faker::Pokemon.name, description: Faker::ChuckNorris.fact, mod_id: 1)
end

User.create!(username: Faker::GameOfThrones.character, password: "random")

10.times do |i|
  10.times do
    Post.create!(title: Faker::StarWars.vehicle, content: Faker::Hipster.paragraph, author_id: 1, sub_id: i+1)
  end

end
