module Todo
  module UseCases
    class PresentTodos
      def initialize(todo_repo:)
        @todo_repo = todo_repo
      end

      def present_all
        todo_repo.all
      end

      def present_todos
        todo_repo.todos
      end

      private
      attr_reader :todo_repo
    end
  end
end
