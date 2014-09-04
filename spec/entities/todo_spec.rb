require_relative '../spec_helper.rb'

describe Todo::Todo do
  let(:todo) { Todo::Todo.new("Get Groceries") }

  describe '.new' do
    it "sets value, status and id" do
      expect(todo.value).to eq("Get Groceries")
      expect(todo.status).to eq("incomplete")
      expect(todo.id).to be_nil
    end
  end

  describe '#complete' do
    it "sets status to complete" do
      expect(todo.status).to eq("incomplete")
      expect(todo.complete).to eq("complete")
      expect(todo.status).to eq("complete")
    end
  end
end
