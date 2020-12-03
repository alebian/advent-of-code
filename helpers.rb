module Helpers
  module_function

  def read_input
    read_lines('./input.txt')
  end

  def read_lines(file)
    File.read(file).split("\n")
  end
end
