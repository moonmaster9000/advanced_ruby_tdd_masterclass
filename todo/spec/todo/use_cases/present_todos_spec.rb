require "todo/use_cases/present_todos"
require "todo/use_cases/add_todos"
require "todo/entities/todo"
require "doubles/in_memory_todo_repo"

module Todo::UseCases
  describe PresentTodos do
    context "todos have been previously persisted" do
      before do
        AddTodos.new(todo_repo: todo_repo).add(description: persisted_todo_description)
      end

      it "returns presentable todos" do
        todos = PresentTodos.new(todo_repo: todo_repo).present_all

        expect(todos.collect(&:description)).to include persisted_todo_description
      end
    end

    let(:todo_repo) { InMemoryTodoRepo.new }
    let(:persisted_todo_description) { "new todo" }
  end
end
