require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

class ContactsTest < Test::Unit::TestCase
  context "Contacts Model" do
    should 'construct new instance' do
      @contacts = Contacts.new
      assert_not_nil @contacts
    end
  end
end
