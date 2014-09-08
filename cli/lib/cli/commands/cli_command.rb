class CliCommand
  def initialize(todo_repo: FlatFilePersistence::TodoRepo.new, input_data: [])
    @todo_repo = todo_repo
    @input_data = input_data
  end

  private
  attr_reader(
    :todo_repo,
    :input_data,
  )
end
