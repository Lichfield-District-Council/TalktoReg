class Subcategory < ActiveRecord::Base
	belongs_to :categories
	has_one :contacts
end
