Dir[File.join(__dir__, "commands", "*.rb")].each do |file|
  require file
end
