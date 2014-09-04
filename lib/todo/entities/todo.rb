module Todo
  class Todo
    attr_accessor :value, :status
    attr_reader :id
    def initialize(value, status="incomplete", id=nil)
      @value = value
      @status = status
      @id = id
    end

    def complete
      @status = "complete"
    end
  end
end
