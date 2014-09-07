require "todo/use_cases/do"
require "todo/use_cases/add_todos"
require "doubles/in_memory_todo_repo"
require "doubles/spy_use_case_observer"
require "todo_plugin_contributors/valid_todo_stub"

module Todo::UseCases
  describe Do do
    before do
      AddTodos.new(todo_repo: todo_repo).add(valid_todo_attributes)
    end

    context "when the todo is not yet done" do
      it "persists the todo as 'done'" do
        do_todo(todo_description)

        expect(todo_repo.done.collect(&:description)).to include(todo_description)
      end

      it "notifies the observer of use case success" do
        do_todo(todo_description)

        expect(observer).to have_observed_use_case_success
      end
    end

    context "when the todo is already done" do
      before do
        do_todo(todo_description)
      end

      it "notifies observer of validation failure" do
        do_todo(todo_description)

        expect(observer).to have_observed_validation_failure("todo is already done")
      end
    end

    def do_todo(description)
      Do.new(
        todo_repo: todo_repo,
        observer: observer,
      ).do_todo(description: description)
    end

    let(:valid_todo_attributes) { ValidTodoStub.attributes }
    let(:todo_description) { valid_todo_attributes[:description] }
    let(:todo_repo) { InMemoryTodoRepo.new }
    let(:observer) { SpyUseCaseObserver.new }
  end
end
