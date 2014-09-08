require "cli/commands"

module Cli
  class Router
    include Cli::Commands

    def initialize(command=ARGV.first)
      @command = command
    end

    def route
      case command
        when "destroy"
          DestroyCommand.new.execute
        when "add"
          AddCommand.new.execute
        when "list"
          ListCommand.new.execute
      end
    end

    private
    attr_reader(
      :command,
    )
  end
end
