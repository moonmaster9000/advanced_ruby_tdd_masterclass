require "cli/commands/cli_command"

module Cli
  module Commands
    class DestroyCommand < CliCommand
      def execute
        Todo::UseCases::DestroyTodos.new(todo_repo: todo_repo).destroy_all
      end
    end
  end
end
