#!/usr/bin/env ruby

class TodoRepo
  def initialize
    @repo_file = "todo_list"
  end

  def destroy_all
    File.delete(repo_file)
  end

  def create(todo)
    File.write(repo_file, todo.description + "\n")
  end

  def all
    File.read(repo_file)
  end

  private
  attr_reader :repo_file
end

todo_repo = TodoRepo.new
$LOAD_PATH.unshift "todo/lib"
require "todo"

class CliCommand
  def initialize
    @todo_repo = TodoRepo.new
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
    puts Todo::UseCases::PresentTodos.new(todo_repo: todo_repo).present_all
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
