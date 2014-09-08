require "cli/commands/cli_command"

module Cli
  module Commands
    class ListCommand < CliCommand
      def execute
        puts Todo::UseCases::PresentTodos.new(todo_repo: todo_repo).present_todos.collect(&:description).join("\n")
      end
    end
  end
end
