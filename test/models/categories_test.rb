require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

class CategoriesTest < Test::Unit::TestCase
  context "Categories Model" do
    should 'construct new instance' do
      @categories = Categories.new
      assert_not_nil @categories
    end
  end
end
