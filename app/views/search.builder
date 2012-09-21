xml.instruct!
xml.categories do
	@categories.each do |category|
		xml.category do
			xml.name category.name
			xml.subtitle category.subtitle
			@contacts[category.id].each do |contact|
				xml.contact do
					xml.name contact.name
					xml.address contact.address
					xml.tel contact.tel
					xml.email contact.email
					xml.website contact.website
				end
			end
		end
	end
end