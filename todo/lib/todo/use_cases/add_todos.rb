require "todo/entities/todo"

module Todo
  module UseCases
    class AddTodos
      def initialize(todo_repo:)
        @todo_repo = todo_repo
      end

      def add(description:)
        todo_repo.create(Todo::Entities::Todo.new(description: description))
      end

      private
      attr_reader :todo_repo
    end
  end
end
