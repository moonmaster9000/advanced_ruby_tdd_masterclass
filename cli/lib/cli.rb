require "flat_file_persistence"
require "todo"

Dir[File.join(__dir__, "**", "*.rb")].each do |file|
  require file
end
