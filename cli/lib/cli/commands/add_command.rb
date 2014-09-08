require "cli/commands/requires_todo_description_command"


module Cli
  module Commands
    class AddCommand < RequiresTodoDescriptionCommand
      def execute
        Todo::UseCases::AddTodos.new(
          todo_repo: todo_repo,
          observer: self,
        ).add(description: todo_description)
      end

      def use_case_succeeded(*)
      end

      def validation_failed(todo)
        puts todo.failed_validations.join("\n")
      end

      private
      def todo_description
        input_data.join(" ")
      end
    end
  end
end
