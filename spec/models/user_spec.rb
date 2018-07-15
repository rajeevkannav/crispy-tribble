require 'rails_helper'
require 'faker'

RSpec.describe User, type: :model do


	# describe "#current_partner" do
	# 	context "When current_partner is not available" do
	# 		it "user should not be able respond for extra attribute(s)" do
	# 			user = User.new(name: Faker::Name.name, phone: Faker::PhoneNumber.phone_number)
	# 			expect(user).not_to respond_to(:nickname)
	# 			expect(user).not_to respond_to(:age)
	# 			expect(user).not_to respond_to(:gender)
	# 		end
	# 	end

	# 	context "When current_partner is available" do
	# 		it "user should not be able respond for available extra attribute(s) only" do
	# 			Partner.current_partner = '1'
	# 			user = User.new(name: Faker::Name.name, phone: Faker::PhoneNumber.phone_number)
	# 			expect(user).to respond_to(:nickname)
	# 			expect(user).to respond_to(:gender)

	# 			expect(user).not_to respond_to(:age)
	# 		end

	# 		it "user should not be able respond for available extra attribute(s) only" do
	# 			Partner.current_partner = '2'
	# 			user = User.new(name: Faker::Name.name, phone: Faker::PhoneNumber.phone_number)
	# 			expect(user).to respond_to(:nickname)
	# 			expect(user).to respond_to(:age)
	# 			expect(user).to respond_to(:gender)
	# 		end
	# 	end

	# end  
	
	# describe "#Where" do		
	# 	before do
	# 		Partner.current_partner = '1'
	# 		5.times do |i|
	# 			user = User.new(name: "1_NAME_#{i+1}", phone: "1111111_#{i+1}")
	# 			user.nickname = "1_nickname_#{i+1}"
	# 			user.gender = "male"
	# 			user.save
	# 		end			 
	# 	end
	# 	context "When current_partner is not available" do
	# 		it "Where clause should ignore extra attribute(s)" do
	# 			Partner.current_partner = nil
	# 			expect(User.where(age: 23).count).to eq User.count
	# 		end
	# 	end
	# end

	describe "#Where" do		
		before do
			Partner.current_partner = '2'
			5.times do |i|
				user = User.new(name: "2_NAME_#{i+1}", phone: "22222_#{i+1}")
				user.nickname = "2_nickname_#{i+1}"
				user.gender = "Female"
				user.gender = i+ 20
				user.save
			end			 
		end
		context "When current_partner is not available" do
			it "Where clause should ignore extra attribute(s)" do
				Partner.current_partner = "2"
				users = User.where(age: 23, gender: 'Female', name: '2_NAME_3', nickname: '2_nickname_3')

				puts users.inspect
				puts users.first.age.inspect
				puts users.first.gender.inspect
				puts users.first.nickname.inspect
				
				# expect(.count).to eq User.count
			end
		end
	end


end
