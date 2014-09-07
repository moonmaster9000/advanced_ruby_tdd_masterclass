#!/usr/bin/env ruby

$LOAD_PATH.unshift "flat_file_persistence/lib"
$LOAD_PATH.unshift "todo/lib"
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
