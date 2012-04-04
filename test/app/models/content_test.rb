require File.expand_path(File.dirname(__FILE__) + '/../../test_config.rb')

class ContentTest < Test::Unit::TestCase
  context "Content Model" do
    should 'construct new instance' do
      @content = Content.new
      assert_not_nil @content
    end
  end
end
