require "todo/entities/todo"
require "fileutils"

module FlatFilePersistence
  class TodoRepo
    def initialize
      @repo_file = "todo_list"
    end

    def destroy_all
      @all = []
      persist
    end

    def update(todo)
      found_todo = all.find { |t| t == todo }
      all.delete(found_todo)
      all << todo
      persist
    end

    def find_by_description(description)
      all.find { |t| t.description == description }
    end

    def create(todo)
      all << todo
      persist
    end

    def all
      @all ||= begin
        if File.exist?(repo_file)
          Marshal.load(File.read(repo_file))
        else
          []
        end
      end
    end

    def done
      all.select(&:done?)
    end

    def todos
      all - done
    end

    def empty?
      all.empty?
    end

    private
    attr_reader :repo_file

    def persist
      File.write(repo_file, Marshal.dump(all))
    end
  end
end
