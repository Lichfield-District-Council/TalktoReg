require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

class CouncilTest < Test::Unit::TestCase
  context "Council Model" do
    should 'construct new instance' do
      @council = Council.new
      assert_not_nil @council
    end
  end
end
