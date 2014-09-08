require "cli/commands"

module Cli
  class Router
    include Cli::Commands

    def initialize(command: ARGV.first, input_data: ARGV[1..-1])
      @command = command
      @input_data = input_data
    end

    def route
      command_class.new(input_data: input_data).execute
    end

    private
    attr_reader(
      :command,
      :input_data,
    )

    def command_class
      Module.const_get("Cli::Commands::#{command.capitalize}Command")
    end
  end
end
