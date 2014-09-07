Dir[File.join(__dir__, "flat_file_persistence", "**", "*")].each do |file|
  require file
end
