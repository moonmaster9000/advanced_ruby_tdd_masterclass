module Todo
  module UseCases
    class DestroyTodos
      def initialize(todo_repo:)
        @todo_repo = todo_repo
      end

      def destroy_all
        todo_repo.destroy_all
      end

      private
      attr_reader :todo_repo
    end
  end
end
