module Todo
  class User
    attr_reader :name, :email_address, :id
    def initialize(name, email, id=nil)
      @name = name
      @email_address = email
      @id = id
    end
  end
end
