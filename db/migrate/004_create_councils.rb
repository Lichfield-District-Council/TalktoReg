class CreateCouncils < ActiveRecord::Migration
  def self.up
    create_table :councils do |t|
      t.string :name
      t.string :snac
      t.timestamps
    end
  end

  def self.down
    drop_table :councils
  end
end
