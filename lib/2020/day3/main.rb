require_relative '../../helpers'

INPUT = Helpers.read_input(2020, 3)

RIGHT = 3
# DOWN = 1

TREE = '#'
SPACE = '.'

# current_y = 0
current_x = 0

trees = 0
spaces = 0

# Skip the first line and go through each line (we don't need the Y movement for now since it's 1)
INPUT[1..-1].each do |line|
  current_x = (current_x + RIGHT) % line.size

  case line[current_x]
    when TREE then trees += 1
    when SPACE then spaces += 1
  end
end

puts "Spaces seen: #{spaces}"
puts "Trees seen: #{trees}"
