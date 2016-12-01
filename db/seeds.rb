# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

10.times do
  User.create!(user_name: Faker::Name.name)
end

10.times do |i|
  Poll.create!(title: Faker::Book.title, author_id: i + 1)
end

10.times do |i|
  3.times do
    Question.create!(body: "Where are the #{Faker::Team.name}", poll_id: i + 1)
  end
end

10.times do |i|
  3.times do
    AnswerChoice.create!(body: Faker::ChuckNorris.fact, question_id: i + 1)
  end
end

# 100.times do
#   Response.create!(user_id: rand(10) + 1, answer_choice_id: rand(30) + 1 )
# end

Response.create!(user_id: 10, answer_choice_id: 1)
Response.create!(user_id: 2, answer_choice_id: 1)
Response.create!(user_id: 3, answer_choice_id: 1)
Response.create!(user_id: 4, answer_choice_id: 1)
Response.create!(user_id: 5, answer_choice_id: 1)
Response.create!(user_id: 6, answer_choice_id: 1)
Response.create!(user_id: 7, answer_choice_id: 1)
Response.create!(user_id: 8, answer_choice_id: 1)
Response.create!(user_id: 9, answer_choice_id: 1)
