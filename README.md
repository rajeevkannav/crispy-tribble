# crispy-tribble

###  Handling nasty custom attributes using ActiveSupport::Concern 

#### Prerequisites

 * Rails 5.2.0
 * ruby 2.5.1p57 (2018-03-29 revision 63029) [x86_64-linux]
 * Sqilte3 3.11.0 2016-02-15 17:29:24 3d862f207e3adc00f78066799ac5a8c282430a5f for development
 * Ubuntu 16.04.4 LTS(Codename: xenial) (Used as development machine)

#### Installation

	git clone git@github.com:rajeevkannav/crispy-tribble.git
	cd crispy-tribble  
	gem install bundler
	bundle install
	rails db:create db:migrate db:seed
	rails s

#### Considerations(philosophy)
	
Assuming system consists a Partner at any given time which is Partner.current_partner.
	Partner's definination are available into `models/partner.rb`.

By default an user object will have to columns/attributes only which are name and phone.
and as per requirement Partner.current_partner = '2' needs [:nickname, :gender, :age] custom-attributes but
Partner.current_partner = '1' needs only [:nickname, :gender]. further definations can be added to partner.rb

Once in the system Partner.current_partner is available the object of model in which includes `ExtraAttributable` will have the ability to respond to required custom_attributes.

As and when ActiveSupport::Concern `ExtraAttributable` included into any model (User in our case) and Partner.current_partner is available. then every object of User model will be able to respond to custom_attributes corresponding to its defination.

custom_attributes will be saved into ExtraAttributes.(that's it.)

For an example : 

		## By default
		user = User.new(name: "Rajeev Sharma", phone: '9811288952') 
		#user.age, user.gender, user.nickname will raise  NoMethodError (undefined method  		
		user.save # only name and phone will be saved for user.


		## For Partner.current_partner = '2' required custom attributes are [:nickname, :gender, :age].
		
		Partner.current_partner = '2' 
		user = User.new(name: "Rajeev Sharma", phone: '9811288952')
		user.nickname = "Ashu"
		user.age = 32
		user.gender = "Male"
		user.save # only defined custom attributes will be saved for user.
		reload!
		
		Partner.current_partner = '2'
		user = User.where(nickname: 'Ashu', name: "Rajeev Sharma", age: 34, gender: "Male").first
		user.age, user.gender, user.nickname


		## For Partner.current_partner = '1' required custom attributes are [:nickname, :gender].
		reload!
		Partner.current_partner = '1'
		User.where(nickname: 'Ashu', name: "Rajeev Sharma", age: 34, gender: "Male").first ## NOT AGE
		user.gender, user.nickname 
		# user.age NoMethodError (undefined method `age' 
#### Tests 

To run tests `rspec .`  
