require_relative '../../helpers'

INPUT = Helpers.read_input(2020, 4, separator: "\n\n")

REQUIRED_FIELDS = %i[byr iyr eyr hgt hcl ecl pid]
OPTIONAL_FIELDS = %i[cid]

puts INPUT
  .map { |i| i.split(/\s/) }
  .map { |c| c.map { |raw| raw.split(':').first.to_sym } - OPTIONAL_FIELDS }
  .map { |c| REQUIRED_FIELDS - c }
  .select(&:empty?)
  .count
