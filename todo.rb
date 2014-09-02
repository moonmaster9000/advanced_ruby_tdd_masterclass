#!/usr/bin/env ruby


case ARGV.first
  when "destroy"
    File.delete("todo_list")
  when "add"
    File.write("todo_list", ARGV[1..-1].join(" "))
  when "list"
    puts File.read("todo_list")
end
