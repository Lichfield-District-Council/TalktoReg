class AddSubcategoryIdToContacts < ActiveRecord::Migration
  def change
  	change_table :contacts do |t|
  		t.integer :subcategory_id
  	end
  end
end
