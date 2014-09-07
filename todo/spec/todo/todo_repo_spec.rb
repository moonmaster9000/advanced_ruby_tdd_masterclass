require "todo/entities/todo"
require "doubles/valid_todo_stub"

def build_repo_spec(todo_repo_class)
  describe "#{todo_repo_class}" do
    it "adds todos into the repository" do
      todo_repo.create(todo)

      expect(todo_repo.all).to include todo
    end

    it "destroys all todos in the repository" do
      todo_repo.create(todo)

      todo_repo.destroy_all

      expect(todo_repo).to be_empty
    end

    it "provides access to todos, dones, and all" do
      todo_repo.create(todo)
      todo_repo.create(done_todo)

      expect(todo_repo.all).to include todo, done_todo

      expect(todo_repo.done).not_to include todo
      expect(todo_repo.done).to include done_todo

      expect(todo_repo.todos).not_to include done_todo
      expect(todo_repo.todos).to include todo
    end

    it "updates todos" do
      todo_repo.create(todo)

      todo.do!

      todo_repo.update(todo)

      expect(todo_repo.done).to include todo
    end

    it "finds todos by description" do
      todo_repo.create(todo)
      expect(todo_repo.find_by_description(todo.description)).to eq todo
    end

    let(:valid_todo_attributes) { ValidTodoStub.attributes }
    let(:todo_repo)             { todo_repo_class.new }
    let(:todo)                  { Todo::Entities::Todo.new(valid_todo_attributes) }
    let(:done_todo)             { Todo::Entities::Todo.new(valid_todo_attributes).tap &:do! }
  end
end
