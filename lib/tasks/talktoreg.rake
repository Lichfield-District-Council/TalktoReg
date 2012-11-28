task :councils => :environment do
	require 'rubygems'
	require 'weary'
	require 'httparty'
	require 'json'
	
	results = JSON.parse HTTParty.get("https://api.scraperwiki.com/api/1.0/datastore/sqlite?format=jsondict&name=local_authority_contact_details&query=select%20*%20from%20%60swdata%60").response.body
	
	results.each do |result|
		council = Council.find_or_create_by_snac(result["snac"])
		
		council.name = result["name"]
		council.email = result["email"]
		council.tel = result["tel1"]
		council.website = result["url"]
		council.contacturl = result["contacturl"]
		
		council.save
	end
	
end