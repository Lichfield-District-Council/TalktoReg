class Contacts < ActiveRecord::Base
	validates_presence_of :name, :snac, :category_id
	belongs_to :categories
	belongs_to :subcategories
end
