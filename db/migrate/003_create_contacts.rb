class CreateContacts < ActiveRecord::Migration
  def self.up
    create_table :contacts do |t|
      t.string :name
      t.text :address
      t.string :tel
      t.string :email
      t.string :website
      t.text :contact
      t.text :hours
      t.text :howto
      t.string :snac
      t.integer :category_id
      t.timestamps
    end
  end

  def self.down
    drop_table :contacts
  end
end
