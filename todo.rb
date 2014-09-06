#!/usr/bin/env ruby

class TodoRepo
  def initialize
    @repo_file = "todo_list"
  end

  def destroy_all
    File.delete(repo_file)
  end

  def create(todo_text)
    File.write(repo_file, todo_text + "\n")
  end

  def all
    File.read(repo_file)
  end

  private
  attr_reader :repo_file
end

todo_repo = TodoRepo.new

case ARGV.first
  when "destroy"
    todo_repo.destroy_all
  when "add"
    todo_repo.create(ARGV[1..-1].join(" "))
  when "list"
    puts todo_repo.all
end
