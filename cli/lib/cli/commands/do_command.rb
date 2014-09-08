require "cli/commands/requires_todo_description_command"

module Cli
  module Commands
    class DoCommand < RequiresTodoDescriptionCommand
      def execute
        Todo::UseCases::Do.new(
          todo_repo: todo_repo,
          observer: self,
        ).do_todo(description: todo_description)
      end

      def use_case_succeeded(*)
      end

      def validation_failed(todo)
        puts todo.failed_validations.join("\n")
      end
    end
  end
end
