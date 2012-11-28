class AddFieldsToCouncils < ActiveRecord::Migration
  def change
  	change_table :councils do |t|
  		t.string :email
  		t.string :tel
  		t.string :website
  		t.string :contacturl
  	end
  end
end
