require "todo/entities/todo"

module Todo
  module UseCases
    class AddTodos
      class NullObserver
        def use_case_succeeded(*); end
        def validation_failed(*); end
      end

      def initialize(todo_repo:, observer: NullObserver.new)
        @todo_repo = todo_repo
        @observer = observer
      end

      def add(attributes)
        AddMethod.new(
          attributes: attributes,
          todo_repo: todo_repo,
          observer: observer
        ).execute
      end

      private
      attr_reader(
        :todo_repo,
        :observer,
      )

      class AddMethod
        def initialize(
          attributes:,
            todo_repo:,
            observer:
        )
          @attributes = attributes
          @todo_repo = todo_repo
          @observer = observer
        end

        def execute
          create_todo

          if valid?
            persist
            notify_of_success
          else
            notify_of_failure
          end
        end

        private
        attr_reader(
          :todo,
          :attributes,
          :observer,
          :todo_repo,
        )

        def create_todo
          @todo = Todo::Entities::Todo.new(attributes)
        end

        def valid?
          todo.valid?
        end

        def persist
          todo_repo.create(todo)
        end

        def notify_of_success
          observer.use_case_succeeded
        end

        def notify_of_failure
          observer.validation_failed(failed_validations: todo.failed_validations)
        end
      end
    end
  end
end
