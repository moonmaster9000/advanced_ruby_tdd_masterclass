module FlatFilePersistence
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
end
