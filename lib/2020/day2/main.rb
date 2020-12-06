require_relative '../../helpers'

INPUT = Helpers.read_input(2020, 2)

class PasswordWithPolicy
  def initialize(input)
    parse_input!(input)
  end

  def valid?
    number_of_letters = 0
    @password.split('').each do |letter|
      number_of_letters += 1 if letter == @letter
    end
    @range.cover?(number_of_letters)
  end

  def valid2?
    first_idx = @range.min - 1
    second_idx = @range.max - 1

    return false if @password[first_idx] == @letter && @password[second_idx] == @letter

    @password[first_idx] == @letter || @password[second_idx] == @letter
  end

  private

  def parse_input!(input)
    range, letter, @password = input.split(' ')
    @letter = letter.delete(':')
    splitted_range = range.split('-').map(&:to_i)
    @range = splitted_range[0]..splitted_range[1]
  end
end

result1 =
  INPUT
  .map { |input| PasswordWithPolicy.new(input) }
  .select { |password| password.valid? }
  .count

puts result1

result2 =
  INPUT
  .map { |input| PasswordWithPolicy.new(input) }
  .select { |password| password.valid2? }
  .count

puts result2
