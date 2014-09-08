#!/usr/bin/env ruby

def path_to_todo_app_component(component)
  File.expand_path(File.join(__dir__, "..", "..", "#{component}", "lib"))
end

def add_to_load_path(components)
  components.each do |component|
    $LOAD_PATH.unshift path_to_todo_app_component(component)
  end
end

add_to_load_path(
  %w(flat_file_persistence todo cli)
)

require "cli"

include Cli::Commands

case ARGV.first
  when "destroy"
    DestroyCommand.new.execute
  when "add"
    AddCommand.new.execute
  when "list"
    ListCommand.new.execute
end
