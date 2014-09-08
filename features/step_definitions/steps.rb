module TodoDsl
  module Cli
    def destroy
      todo_command "destroy"
    end

    def add(item)
      todo_command "add #{item}"
    end

    def todos
      todo_command "list"
    end

    def todo_item
      "new item"
    end

    private
    def todo_command(command)
      `cli/bin/todo #{command}`
    end
  end

  module Domain
    def self.extended(*)
      $LOAD_PATH.unshift "todo/lib"
      require "todo"
    end

    def destroy
      Todo::UseCases::DestroyTodos.new(todo_repo: todo_repo).destroy_all
    end

    def add(description)
      Todo::UseCases::AddTodos.new(todo_repo: todo_repo).add(description: description)
    end

    def todos
      Todo::UseCases::PresentTodos.new(todo_repo: todo_repo).present_todos.collect(&:description)
    end

    def do_todo(description)
      Todo::UseCases::Do.new(todo_repo: todo_repo).do_todo(description: description)
    end

    def todo_item
      "new item"
    end

    private
    def todo_repo
      @todo_repo ||= begin
        require_relative "../../todo/spec/doubles/in_memory_todo_repo"
        InMemoryTodoRepo.new
      end
    end
  end
end

dsl = ENV["LEVEL"] || "Domain"

World TodoDsl.const_get(dsl)

Given(/^an empty todo list$/) do
  destroy
end

When(/^I add an item to the list$/) do
  add(todo_item)
end

Then(/^I should see it in the list$/) do
  expect(todos).to include(todo_item)
end


Given(/^there is a todo$/) do
  add(todo_item)
end

When(/^I do it$/) do
  do_todo(todo_item)
end

Then(/^it should no longer show up in the list of todos$/) do
  expect(todos).not_to include(todo_item)
end
