require "todo/use_cases/null_observer"

module Todo
  module UseCases
    class Do
      def initialize(observer: NullObserver.new, todo_repo:)
        @todo_repo = todo_repo
        @observer = observer
      end

      def do_todo(description:)
        DoTodoMethod.new(
          todo_repo: todo_repo,
          observer: observer,
          description: description,
        ).execute
      end

      private
      attr_reader(
        :observer,
        :todo_repo,
      )

      class DoTodoMethod
        def initialize(observer:, todo_repo:, description:)
          @todo_repo = todo_repo
          @observer = observer
          @description = description
        end

        def execute
          if already_done?
            notify_validation_failure
          else
            mark_todo_as_done
            persist
            notify_success
          end
        end

        private
        attr_reader(
          :observer,
          :todo_repo,
          :description,
        )

        def notify_success
          observer.use_case_succeeded
        end

        def persist
          todo_repo.update(todo)
        end

        def mark_todo_as_done
          todo.do!
        end

        def notify_validation_failure
          observer.validation_failed(failed_validations: ["todo is already done"])
        end

        def already_done?
          todo.done?
        end

        def todo
          @todo ||= todo_repo.find_by_description(description)
        end
      end
    end
  end
end
