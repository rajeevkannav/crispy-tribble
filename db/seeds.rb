# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


require 'faker'
Partner.current_partner = '1'
5.times do |i|
	user = User.new(name: Faker::Name.name, phone: Faker::PhoneNumber.phone_number)
	user.nickname = Faker::FunnyName.name
	user.gender = Faker::Gender.binary_type
	user.save
end	

Partner.current_partner = '2'
5.times do |i|
	user = User.new(name: Faker::Name.name, phone: Faker::PhoneNumber.phone_number)
	user.nickname = Faker::FunnyName.name
	user.gender = Faker::Gender.binary_type
	user.age = Faker::Number.number(2)
	user.save
end	

