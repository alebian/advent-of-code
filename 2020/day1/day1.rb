require '../../helpers'

INPUT = Helpers.read_input.map(&:to_i)

target = 2020
rest = {}
result = []

INPUT.each do |input|
  if rest[input]
    result << rest[input]
    result << input
    break
  else
    rest[target - input] = input
  end
end

puts result.inspect
puts result[0] * result[1]
