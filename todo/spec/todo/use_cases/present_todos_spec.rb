require "todo/use_cases/present_todos"
require "todo/use_cases/add_todos"
require "todo/entities/todo"
require "doubles/in_memory_todo_repo"
require "doubles/valid_todo_stub"

module Todo::UseCases
  describe PresentTodos do
    context "todos have been previously persisted" do
      before do
        AddTodos.new(todo_repo: todo_repo).add(valid_todo_attributes)
      end

      it "returns presentable todos" do
        todos = PresentTodos.new(todo_repo: todo_repo).present_all

        expect(todos.collect(&:description)).to include todo_description
      end
    end

    let(:todo_repo) { InMemoryTodoRepo.new }
    let(:todo_description) { valid_todo_attributes[:description] }
    let(:valid_todo_attributes) { ValidTodoStub.attributes }
  end
end
