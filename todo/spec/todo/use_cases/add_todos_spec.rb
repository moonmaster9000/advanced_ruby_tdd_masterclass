require "todo/use_cases/add_todos"
require "doubles/in_memory_todo_repo"

module Todo::UseCases
  describe AddTodos do
    context "when the description is present" do
      let(:description) { "a description" }

      it "adds the todo to the repository" do
        AddTodos.new(todo_repo: todo_repo).add(description: description)

        expect(todo_repo.all.collect(&:description)).to include description
      end
    end

    let(:todo_repo) { InMemoryTodoRepo.new }
  end
end
