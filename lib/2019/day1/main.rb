require_relative '../../helpers'

INPUT = Helpers.read_input(2019, 1).map(&:to_i)

def fuel_required(mass)
  (mass / 3.0).floor - 2
end

part1 = INPUT.map { |mass| fuel_required(mass) }.sum
puts part1

part2 = 0
INPUT.each do |mass|
  fuel = fuel_required(mass)
  part2 += fuel

  while (fuel = fuel_required(fuel)) > 0
    part2 += fuel
  end
end

puts part2
