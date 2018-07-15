module ExtraAttributable
	
	extend ActiveSupport::Concern

	included do |base|
		after_initialize :attributes_engine
		has_many :extra_attributes,  -> { where('extra_attributes.kind = ?', base.name)}, foreign_key: 'source_id' 
	end 

	module ClassMethods
		### TODO: Assuming keys are always going to be symbol, as its just a POC level implementation
		def where(options)
			if options.is_a?(Hash)
				ea_attributes = Partner.custom_attributes(self.name).map {|key| key.to_sym} & options.keys
				user_params = options.slice!(*ea_attributes)
				ea_attributes_params = options.map {|k, v| {key: k.to_s, value: v.to_s}}.first
				if ea_attributes_params.blank?
					super
				else
					self.joins(:extra_attributes).where(extra_attributes: ea_attributes_params).where(user_params)
				end	
			end					
		end	
	end	


	private

	def attributes_engine
		__c = class << self
			cattr_accessor :x
			self
		end	

		__c.x = self

		class << self
			attr_accessor *Partner.custom_attributes(self.superclass.name)

			after_save :e_attrs_setter

			Partner.custom_attributes(self.superclass.name).each do |ea_attr|
				ea = ExtraAttribute.where(kind: x.name, source_id: x.id, key: ea_attr.to_s).first
				x.send("#{ea_attr}=".to_sym, ea.value) if ea
			end

			def e_attrs_setter
				Partner.custom_attributes(self.class.name).each do |ea_attr|
					_ea = ExtraAttribute.find_or_create_by(kind: x.class.name, source_id: x.id, key: ea_attr.to_s)
					_ea.value = x.send(ea_attr)
					_ea.save
				end	
			end	
		end	
	end	

end