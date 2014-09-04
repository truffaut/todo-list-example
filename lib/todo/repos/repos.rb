require 'pg'

module Todo
  module Repos
    def self.db_adapter
      @db_adapter = PG.connect(host: 'localhost', dbname: 'todo')
    end

    def self.create_tables
      query = <<-SQL
        CREATE TABLE users (
          name TEXT,
          email_address TEXT,
          id SERIAL PRIMARY KEY
        );
        CREATE TABLE todos (
          value TEXT,
          status TEXT,
          id SERIAL PRIMARY KEY,
          user_id integer REFERENCES users (id)
        );
      SQL

      @db_adapter.exec(query)
    end

    def self.drop_tables
      query = <<-SQL
        DROP TABLE IF EXISTS todos;
        DROP TABLE IF EXISTS users;
      SQL

      @db_adapter.exec(query)
    end
  end
end
