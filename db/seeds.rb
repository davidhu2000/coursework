# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.destroy_all
10.times do
  User.create!(email: Faker::Internet.email)
end

ShortenedUrl.destroy_all
# 10.times do
#   ShortenUrl.create!(short_url: Faker::Number.number(10), long_url: Faker::Internet.url, submitter_id: rand(10) + 1)
# end
ShortenedUrl.create!(short_url: 'abc', long_url: 'facebook.com', submitter_id: 1)
ShortenedUrl.create!(short_url: 'def', long_url: 'github.com', submitter_id: 2)

Visit.destroy_all

100.times do
  Visit.create!(short_url_id: rand(2) + 1, visitor_id: rand(10) + 1)
end

TagTopic.create!(topic: 'social')
TagTopic.create!(topic: 'news')
TagTopic.create!(topic: 'sports')

Tagging.create!(url_id: 1, tag_id: 1)
Tagging.create!(url_id: 1, tag_id: 2)
Tagging.create!(url_id: 1, tag_id: 3)
Tagging.create!(url_id: 2, tag_id: 1)
