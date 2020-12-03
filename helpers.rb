module Helpers
  module_function

  def read_input(separator: "\n")
    read_lines('./input.txt', separator: separator)
  end

  def read_lines(file, separator: "\n")
    File.read(file).split(separator)
  end
end
