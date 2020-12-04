require_relative '../../helpers'

INPUT = Helpers.read_input(2019, 3)

wire1 = INPUT[0].split(',')
wire2 = INPUT[1].split(',')

class Direction
  RIGHT = :right
  LEFT = :left
  UP = :up
  DOWN = :down

  def self.parse(letter)
    case letter
    when 'R' then RIGHT
    when 'L' then LEFT
    when 'U' then UP
    when 'D' then DOWN
    else
      raise "Invalid direction #{letter}"
    end
  end
end

class Movement
  attr_reader :direction, :positions

  def initialize(move)
    dir = move[0]
    positions = move[1..-1]

    @direction = Direction.parse(dir)
    @positions = positions.to_i
  end
end

class Position
  attr_reader :x, :y

  def initialize(x, y)
    @x = x
    @y = y
  end

  def to_s
    "<Position x: #{x}, y: #{y}>\n"
  end
end

wire1_moves = wire1.map { |move| Movement.new(move) }
wire2_moves = wire2.map { |move| Movement.new(move) }

def get_moves(movements)
  cursor = Position.new(0, 0)
  horizontal_ranges = []
  vertical_ranges = []

  movements.each do |movement|
    start = Position.new(cursor.x, cursor.y)

    case movement.direction
    when Direction::UP
      ending = Position.new(cursor.x, cursor.y + movement.positions)
      cursor = Position.new(cursor.x, cursor.y + movement.positions)
      vertical_ranges << { start: start, end: ending }

    when Direction::DOWN
      ending = Position.new(cursor.x, cursor.y - movement.positions)
      cursor = Position.new(cursor.x, cursor.y - movement.positions)
      vertical_ranges << { start: start, end: ending }

    when Direction::LEFT
      ending = Position.new(cursor.x - movement.positions, cursor.y)
      cursor = Position.new(cursor.x - movement.positions, cursor.y)
      horizontal_ranges << { start: start, end: ending }

    when Direction::RIGHT
      ending = Position.new(cursor.x + movement.positions, cursor.y)
      cursor = Position.new(cursor.x + movement.positions, cursor.y)
      horizontal_ranges << { start: start, end: ending }
    end
  end

  [horizontal_ranges, vertical_ranges]
end

wire1_horizontal_ranges, wire1_vertical_ranges = get_moves(wire1_moves)
wire2_horizontal_ranges, wire2_vertical_ranges = get_moves(wire2_moves)

crosses = []

def add_crosses(crosses, horizontal_ranges, vertical_ranges)
  horizontal_ranges.each do |horizontal_range|
    vertical_ranges.each do |vertical_range|
      h_range = [horizontal_range[:start].x, horizontal_range[:end].x].min...[horizontal_range[:start].x, horizontal_range[:end].x].max
      y_range = [vertical_range[:start].y, vertical_range[:end].y].min...[vertical_range[:start].y, vertical_range[:end].y].max

      if h_range.cover?(vertical_range[:start].x)
        if y_range.cover?(horizontal_range[:start].y)
          x = vertical_range[:start].x
          y = horizontal_range[:start].y
          crosses << Position.new(x, y) unless x == 0 && y == 0
        end
      end
    end
  end
end

def manhattan_distance(p1, p2)
  (p1.x - p2.x).abs + (p1.y - p2.y).abs
end

add_crosses(crosses, wire1_horizontal_ranges, wire2_vertical_ranges)
add_crosses(crosses, wire2_horizontal_ranges, wire1_vertical_ranges)

origin = Position.new(0, 0)

puts crosses
  .map { |cross| [cross, manhattan_distance(origin, cross)] }
  .min_by { |c| c[1] }
