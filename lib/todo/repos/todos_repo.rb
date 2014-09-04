module Todo
  module Repos
    class TodosRepo
      def save(todo)
        if todo.id.nil?
          # The todo has no id; that means we need to create it
          sql = "INSERT INTO todos (value, status) VALUES ($1, $2) returning id"
          result = Repos.db_adapter.exec(sql, [todo.value, todo.status])
          todo.instance_variable_set("@id", result[0]["id"])
        else
          # The todo *does* have an id, so we need to update it
          sql = "UPDATE todos SET (value, status) = ($1, $2) WHERE id=$3"
          Repos.db_adapter.exec(sql, [todo.value, todo.status, todo.id])
        end
      end

      #finds a Todo by id
      def find(todo_id)
        sql = "SELECT * FROM todos WHERE id=$1"
        result = Repos.db_adapter.exec(sql, [todo_id])
        Todo.new(result[0]["value"], result[0]["status"], result[0]["id"])
      end

      #finds all Todos with a given status
      def find_by_status(status)
        sql = "SELECT * FROM todos WHERE status=$1"
        result = Repos.db_adapter.exec(sql, [status])
        if result.to_a != []
          result.map do |row|
            Todo.new(row["value"], row["status"], row["id"])
          end
        end
      end
    end
  end
end
