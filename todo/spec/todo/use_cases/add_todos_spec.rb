require "todo/use_cases/add_todos"
require "doubles/in_memory_todo_repo"
require "doubles/spy_use_case_observer"
require "doubles/valid_todo_stub"

module Todo::UseCases
  describe AddTodos do
    context "when the description is present" do
      let(:description) { "a description" }

      it "adds the todo to the repository" do
        add_todo
        expect(todo_repo.all.collect(&:description)).to include description
      end

      it "notifies the observer of success" do
        add_todo
        expect(observer).to have_observed_use_case_success
      end
    end


    describe "when the description is not present" do
      EMPTY_VALUES = [
        nil,
        "",
        "  ",
      ]

      EMPTY_VALUES.each do |description_value|
        context "when the description is #{description_value.inspect}" do
          let(:description) { description_value }

          it "does not add the todo to the repository" do
            add_todo
            expect(todo_repo).to be_empty
          end

          it "tells observers about the failure" do
            add_todo
            expect(observer).to have_observed_validation_failure("description must be present")
          end
        end
      end
    end

    def add_todo
      AddTodos.new(
        todo_repo: todo_repo,
        observer: observer,
      ).add(
        valid_todo_attributes.merge(description: description)
      )
    end

    let(:todo_repo) { InMemoryTodoRepo.new }
    let(:observer) { SpyUseCaseObserver.new }
    let(:valid_todo_attributes) { ValidTodoStub.attributes }
  end
end
