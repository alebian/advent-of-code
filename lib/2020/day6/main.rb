require_relative '../../helpers'

INPUT = Helpers.read_input(2020, 6, separator: "\n\n")

result1 = INPUT.map do |input|
  answers = Hash.new(0)
  input.split('').each do |letter|
    next if letter == "\n"
    answers[letter] += 1
  end
  answers.keys.count
end

puts result1.sum

result2 = INPUT.map do |input|
  answers = Hash.new(0)
  people = input.split("\n").size

  input.split('').each do |letter|
    next if letter == "\n"
    answers[letter] += 1
  end
  answers.select { |k, v| v == people }.keys.count
end

puts result2.sum
