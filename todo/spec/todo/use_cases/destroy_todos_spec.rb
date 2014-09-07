require "todo/use_cases/destroy_todos"
require "todo/use_cases/add_todos"
require "todo/entities/todo"
require "doubles/in_memory_todo_repo"
require "todo_plugin_contributors/valid_todo_stub"

module Todo::UseCases
  describe DestroyTodos do
    context "todos have been previously persisted" do
      before do
        Todo::UseCases::AddTodos.new(todo_repo: todo_repo).add(valid_todo_attributes)
      end

      it "destroys the persisted todos" do
        DestroyTodos.new(todo_repo: todo_repo).destroy_all

        expect(todo_repo.all).to be_empty
      end
    end

    let(:todo_repo) { InMemoryTodoRepo.new }
    let(:valid_todo_attributes) { ValidTodoStub.attributes }
  end
end
