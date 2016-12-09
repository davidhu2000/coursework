# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(email: 'dj', password: 'asdfasdf')

10.times do
  Band.create!(name: Faker::Name.name)
end

10.times do |i|
  2.times do
    Album.create!(band_id: i + 1, name: Faker::Hipster.sentence(4), edition: 'studio')
  end
end

20.times do |i|
  5.times do
    Track.create!(album_id: i + 1, name: Faker::Hacker.ingverb, category: 'regular', lyrics: Faker::ChuckNorris.fact)
  end
end
