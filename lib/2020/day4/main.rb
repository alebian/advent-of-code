require_relative '../../helpers'

INPUT = Helpers.read_input(2020, 4, separator: "\n\n")

REQUIRED_FIELDS = %i[byr iyr eyr hgt hcl ecl pid]
OPTIONAL_FIELDS = %i[cid]

valid1 = INPUT
  .map { |i| i.split(/\s/) }
  .map { |c| c.map { |raw| raw.split(':').first.to_sym } - OPTIONAL_FIELDS }
  .map { |c| REQUIRED_FIELDS - c }
  .select(&:empty?)
  .count

puts valid1

def valid?(hash)
  return false if hash['byr'].to_i < 1920 || hash['byr'].to_i > 2002

  return false if hash['iyr'].to_i < 2010 || hash['iyr'].to_i > 2020

  return false if hash['eyr'].to_i < 2020 || hash['eyr'].to_i > 2030

  h_match = hash['hgt'].to_s.match(/(\d+)(cm|in)/)
  return false unless h_match
  val = h_match[1].to_i
  case h_match[2]
  when 'cm'
    return false if val < 150 || val > 193
  when 'in'
    return false if val < 59 || val > 76
  end

  return false if hash['hcl'].to_s.size > 7
  return false unless hash['hcl'].to_s.match?(/#[a-f0-9]{6}/)

  return false unless %w[amb blu brn gry grn hzl oth].include?(hash['ecl'])

  return false if hash['pid'].to_s.size > 9
  return false unless hash['pid'].to_s.match?(/\d{9}/)

  true
end

puts INPUT
  .map { |i| i.split(/\s/) }
  .map { |c| c.map { |a| a.split(':') }.to_h }
  .select { |h| valid?(h) }
  .count
