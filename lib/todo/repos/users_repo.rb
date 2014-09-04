module Todo
  module Repos
    class UsersRepo
      def save(user)
        if user.id.nil?
          # The user has no id; that means we need to create it
          sql = "INSERT INTO users (name, email_address) VALUES ($1, $2) returning id"
          result = Repos.db_adapter.exec(sql, [user.name, user.email_address])
          user.instance_variable_set("@id", result[0]["id"])
        end
      end

      #finds a User by id
      def find(user_id)
        sql = "SELECT * FROM users WHERE id=$1"
        result = Repos.db_adapter.exec(sql, [user_id])
        User.new(result[0]["name"], result[0]["email_address"], result[0]["id"])
      end

      def find_by_email(email)
        sql = "SELECT * FROM users WHERE email_address=$1"
        result = Repos.db_adapter.exec(sql, [email])
        User.new(result[0]["name"], result[0]["email_address"], result[0]["id"])
      end
    end
  end
end


