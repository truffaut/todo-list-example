require_relative '../spec_helper.rb'

describe Todo::Repos::UsersRepo do
  let(:user) { Todo::User.new("Geoffrey", "geo@example.com") }

  before(:all) do
    Todo::Repos.instance_variable_set(:@db_adapter, PG.connect(host: 'localhost', dbname: 'todo-test'))
  end

  before(:each) do
    Todo::Repos.drop_tables
    Todo::Repos.create_tables
  end

  describe '#save' do
    it "should save the user and set the id" do
      expect(user.id).to be_nil
      Todo.users_repo.save(user)
      expect(user.id).to eq("1")
    end
  end

  describe '#find' do
    it "should find a User by its id" do
      Todo.users_repo.save(user)
      found = Todo.users_repo.find(user.id)
      expect(found.name).to eq(user.name)
    end
  end

  describe '#find_by_email' do
    it "should find a user with a given email" do
      user2 = Todo::User.new("Lee", "lee@example.com")
      Todo.users_repo.save(user)
      Todo.users_repo.save(user2)

      found_user = Todo.users_repo.find_by_email("geo@example.com")
      expect(found_user.id).to eq(user.id)
      found_user2 = Todo.users_repo.find_by_email("lee@example.com")
      expect(found_user2.id).to eq(user2.id)
    end
  end
end
