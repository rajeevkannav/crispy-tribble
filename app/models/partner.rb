class Partner

	PARTNERS = {
		"1" => {
			"User" => [:nickname, :gender],
			"Book" => [:page_count]
		}, 
		"2" => {
			"User" => [:nickname, :gender, :age],
			"Book" => [:page_count, :author]
		}
	}

	cattr_accessor :current_partner

	def self.custom_attributes(model_name)
		PARTNERS[current_partner][model_name] rescue []
	end 
end	