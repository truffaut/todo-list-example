require_relative '../spec_helper.rb'

describe Todo::Repos::TodosRepo do
  let(:todo) { Todo::Todo.new("Mow yard") }

  before(:all) do
    Todo::Repos.instance_variable_set(:@db_adapter, PG.connect(host: 'localhost', dbname: 'todo-test'))
  end

  before(:each) do
    Todo::Repos.drop_tables
    Todo::Repos.create_tables
  end

  describe '#save' do
    context "when the todo is new" do
      it "should save the todo and set the id" do
        Todo.todos_repo.save(todo)
        expect(todo.id).to eq("1")
      end
    end

    context "when the todo is being updated" do
      it "should update the todo" do
        Todo.todos_repo.save(todo)
        expect(todo.id).to eq("1")
        expect(todo.status).to eq("incomplete")
        todo.complete
        expect(todo.status).to eq("complete")
        Todo.todos_repo.save(todo)

        db_todo = Todo.todos_repo.find(todo.id)
        expect(db_todo.status).to eq("complete")
      end
    end
  end

  describe '#find' do
    it "should find a Todo by its id" do
      Todo.todos_repo.save(todo)
      found = Todo.todos_repo.find(todo.id)
      expect(found.value).to eq(todo.value)
    end
  end

  describe '#find_by_status' do
    it "should find all todos with a given status" do
      todo2 = Todo::Todo.new("Wash car", "complete")
      todo3 = Todo::Todo.new("Finish project")
      Todo.todos_repo.save(todo)
      Todo.todos_repo.save(todo2)
      Todo.todos_repo.save(todo3)

      todos = Todo.todos_repo.find_by_status("incomplete")
      expect(todos.first.value).to eq("Mow yard")
      complete_todos = Todo.todos_repo.find_by_status("complete")
      expect(complete_todos.first.value).to eq("Wash car")
    end
  end
end
