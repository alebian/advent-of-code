require '../../helpers'

INPUT = Helpers.read_input.map(&:to_i)
TARGET = 2020

rest = {}
result = []

INPUT.each do |input|
  if rest[input]
    result << rest[input]
    result << input
    break
  else
    rest[TARGET - input] = input
  end
end

puts result.inspect
puts result[0] * result[1]