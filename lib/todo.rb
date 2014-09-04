module Todo
  def self.todos_repo=(repo)
    @todos_repo = repo
  end

  def self.todos_repo
    @todos_repo
  end

  def self.users_repo=(repo)
    @users_repo = repo
  end

  def self.users_repo
    @users_repo
  end
end

require 'pry-byebug'

require_relative 'todo/entities/user.rb'
require_relative 'todo/entities/todo.rb'

require_relative 'todo/repos/repos.rb'
require_relative 'todo/repos/users_repo.rb'
require_relative 'todo/repos/todos_repo.rb'

Todo.users_repo = Todo::Repos::UsersRepo.new
Todo.todos_repo = Todo::Repos::TodosRepo.new
