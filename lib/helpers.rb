require 'pry'

module Helpers
  module_function

  def read_input(year, day, separator: "\n")
    read_lines("lib/#{year}/day#{day}/input.txt", separator: separator)
  end

  def read_lines(file, separator: "\n")
    File.read(file).split(separator)
  end
end
