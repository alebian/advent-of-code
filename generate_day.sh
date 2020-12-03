#!/usr/bin/env ruby

require 'optparse'
require 'fileutils'

options = { year: nil, day: nil }

parser = OptionParser.new do |parser|
  parser.banner = 'Usage: generate_day.sh --day=day --year=year'

  parser.on('-d', '--day=DAY', 'Specify the advent day') do |day|
    options[:day] = day
  end

  parser.on('-y', '--year=YEAR', 'Specify the advent year') do |year|
    options[:year] = year
  end

  parser.on('-h', '--help', 'Displays help') do
    puts parser
    exit
  end
end

parser.parse!

if options[:year].nil?
  puts "ERROR: Missing year parameter\n\n"
  puts parser
  exit
elsif options[:day].nil?
  puts "ERROR: Missing day parameter\n\n"
  puts parser
  exit
end

path = "#{options[:year]}/day#{options[:day]}"
FileUtils.mkdir_p(path)
FileUtils.touch("#{path}/main.rb")
FileUtils.touch("#{path}/README.md")
FileUtils.touch("#{path}/input.txt")
