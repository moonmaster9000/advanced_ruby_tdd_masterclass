class CliCommand
  def initialize
    @todo_repo = FlatFilePersistence::TodoRepo.new
  end

  private
  attr_reader(
    :todo_repo,
  )
end
