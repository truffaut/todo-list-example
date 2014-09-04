require_relative '../spec_helper.rb'

describe Todo::User do
  let(:user) { Todo::User.new("Mike", "mike@makersquare.com") }
  describe '.new' do
    it "sets name and email address" do
      expect(user.name).to eq("Mike")
      expect(user.email_address).to eq("mike@makersquare.com")
    end
  end
end
