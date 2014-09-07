class InMemoryTodoRepo
  def create(todo)
    all_todos << todo
  end

  def update(*); end

  def all
    all_todos
  end

  def todos
    all_todos.reject(&:done?)
  end

  def destroy_all
    @all_todos = nil
  end

  def empty?
    all.empty?
  end

  def done
    all - todos
  end

  def find_by_description(description)
    all.find { |todo| todo.description == description }
  end

  private
  def all_todos
    @all_todos ||= []
  end
end
