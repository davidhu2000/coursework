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

10.times do
  Poll.create!(title: Faker::Book.title, author_id: rand(10) + 1)
end

10.times do
  Question.create!(body: "Where are the #{Faker::Team.name}", poll_id: rand(10) + 1)
end

10.times do |i|
  3.times do
    AnswerChoice.create!(body: Faker::Team.state, question_id: i)
  end
end

50.times do
  Response.create!(user_id: rand(10) + 1, answer_choice_id: rand(30) + 1 )
end

Response.create!(user_id: 1, answer_choice_id: 1)
