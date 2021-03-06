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


CatRentalRequest.create!(cat_id: 2, status: 'APPROVED', start_date: "2015/1/1", end_date: '2015/2/1')
CatRentalRequest.create!(cat_id: 2, status: 'PENDING', start_date: "2016/1/1", end_date: '2016/2/1')
CatRentalRequest.create!(cat_id: 2, status: 'PENDING', start_date: "2016/1/1", end_date: '2016/2/1')
CatRentalRequest.create!(cat_id: 2, status: 'PENDING', start_date: "2016/1/1", end_date: '2016/2/1')
CatRentalRequest.create!(cat_id: 2, status: 'PENDING', start_date: "2016/1/1", end_date: '2016/2/1')
CatRentalRequest.create!(cat_id: 2, status: 'PENDING', start_date: "2017/1/1", end_date: '2017/2/1')
