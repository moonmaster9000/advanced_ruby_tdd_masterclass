class InMemoryTodoRepo
  def create(todo)
    todos << todo
  end

  def all
    todos
  end

  def destroy_all
    @todos = nil
  end

  private
  def todos
    @todos ||= []
  end
end
