class ChangeContentsToSubcategories < ActiveRecord::Migration
  def self.up
  	rename_table :contents, :subcategories
  end

  def self.down
  	rename_table :subcategories, :contents
  end
end
