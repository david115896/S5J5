class TextValidator < ActiveModel::EachValidator

	def validate_each(record, attribute, value)
		if value.nil? || value.length <2
			record.errors.add(attribute, 'doit avoir 2 caracteres minimum')
		end
	   
		unless value =~ /\A[a-zA-Z0-9\s\.\,\(\)\-\*\'\_\$\?\!\@\#\%\&\*\(\[\])]+\z/
		       record.errors.add(attribute, 'ne doit pas contenir de caracteres speciaux')
		end
	end
end
