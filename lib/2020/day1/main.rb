require_relative '../../helpers'

INPUT = Helpers.read_input(2020, 1).map(&:to_i)
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

# TODO: improve this naive implementation
INPUT.each_with_index do |input1, i|
  INPUT.each_with_index do |input2, j|
    INPUT.each_with_index do |input3, k|
      if i != j && i != k && j != k
        if (input1 + input2 + input3) == TARGET
          puts (input1 * input2 * input3)
        end
      end
    end
  end
end
