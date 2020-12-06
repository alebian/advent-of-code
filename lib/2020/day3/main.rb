require_relative '../../helpers'

INPUT = Helpers.read_input(2020, 3)

TREE = '#'
SPACE = '.'

def find_trees(rows, slope_x, slope_y)
  current_x = 0
  current_y = 0

  trees = 0
  spaces = 0

  while current_y < rows.size
    line = rows[current_y]
    case line[current_x]
      when TREE then trees += 1
      when SPACE then spaces += 1
    end

    current_x = (current_x + slope_x) % line.size
    current_y += slope_y
  end

  return trees
end

puts [
    find_trees(INPUT, 1, 1),
    find_trees(INPUT, 3, 1),
    find_trees(INPUT, 5, 1),
    find_trees(INPUT, 7, 1),
    find_trees(INPUT, 1, 2)
].inject(&:*)
