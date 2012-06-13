class AddCouncilIdToAccounts < ActiveRecord::Migration
  def change
  	change_table :accounts do |t|
  		t.string :snac
  	end
  end
end
