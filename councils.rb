require 'csv'

@hash = Hash.new

CSV.foreach("councils.csv", :quote_char => '"', :col_sep =>';', :row_sep =>:auto) do |row|
	@hash[row[0]] = Hash.new
	@hash[row[0]] = {"id" => row[0], "name" => row[1], "snac" => row[2]}
end

puts @hash

