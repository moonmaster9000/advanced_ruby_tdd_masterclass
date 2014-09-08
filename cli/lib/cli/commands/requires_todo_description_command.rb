require "cli/commands/cli_command"

class RequiresTodoDescriptionCommand < CliCommand
  private
  def todo_description
    input_data.join(" ")
  end
end
