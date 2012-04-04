require 'csv'

@hash = Hash.new

CSV.foreach("categories.csv", :quote_char => '"', :col_sep =>',', :row_sep =>:auto) do |row|
	@hash[row[0]] = Hash.new
	@hash[row[0]] = {"id" => row[0], "name" => row[1], "description" => row[2], "subtitle" => row[3]}
end

puts @hash

