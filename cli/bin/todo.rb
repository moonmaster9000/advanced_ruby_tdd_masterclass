#!/usr/bin/env ruby

def path_to_todo_app_lib(component)
  File.expand_path(File.join(__dir__, "..", "..", "#{component}", "lib"))
end

$LOAD_PATH.unshift path_to_todo_app_lib("flat_file_persistence")
$LOAD_PATH.unshift path_to_todo_app_lib("todo")

require "todo"
require "flat_file_persistence"

class CliCommand
  def initialize
      @todo_repo = FlatFilePersistence::TodoRepo.new
  end

  private
  attr_reader(
    :todo_repo,
  )
end

class DestroyCommand < CliCommand
  def execute
    Todo::UseCases::DestroyTodos.new(todo_repo: todo_repo).destroy_all
  end
end

class AddCommand < CliCommand
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
    ARGV[1..-1].join(" ")
  end
end

class ListCommand < CliCommand
  def execute
    puts Todo::UseCases::PresentTodos.new(todo_repo: todo_repo).present_all.collect(&:description).join("\n")
  end
end

case ARGV.first
  when "destroy"
    DestroyCommand.new.execute
  when "add"
    AddCommand.new.execute
  when "list"
    ListCommand.new.execute
end
