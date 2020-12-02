passwords_and_policies = File.read('./passwords.txt').split("\n")

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

  private

  def parse_input!(input)
    range, letter, @password = input.split(' ')
    @letter = letter.delete(':')
    splitted_range = range.split('-').map(&:to_i)
    @range = splitted_range[0]..splitted_range[1]
  end
end

result =
  passwords_and_policies
  .map { |input| PasswordWithPolicy.new(input) }
  .select { |password| password.valid? }
  .count

puts result
