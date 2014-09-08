require "cli/commands"

module Cli
  class Router
    include Cli::Commands

    def initialize(command=ARGV.first)
      @command = command
    end

    def route
      command_class.new.execute
    end

    private
    attr_reader(
      :command,
    )

    def command_class
      Module.const_get("Cli::Commands::#{command.capitalize}Command")
    end
  end
end
