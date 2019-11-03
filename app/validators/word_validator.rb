class WordValidator < ActiveModel::EachValidator

	def validate_each(record, attribute, value)
		if value.nil? || value.length <2
			record.errors.add(attribute, 'doit avoir 2 caracteres minimum')
		end
	   
		unless value =~ /\A[a-zA-Z\s\-]+\z/
		       record.errors.add(attribute, 'doit seulement contenir des lettres')
		end
	end
end
