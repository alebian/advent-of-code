require_relative '../../helpers'

INPUT = Helpers.read_input(2020, 5)

def binary_search(range, letter, lower, upper)
  case letter
    when lower then (range.min..((range.max + range.min) / 2))
    when upper then (((range.max + range.min) / 2 + 1)..range.max)
  end
end

ids = INPUT.map do |seat|
  row_info = seat[0..6]
  column_info = seat[7..-1]

  row = row_info.split('').reduce(0..127) do |range, letter|
    binary_search(range, letter, 'F', 'B')
  end.min

  column = column_info.split('').reduce(0..7) do |range, letter|
    binary_search(range, letter, 'L', 'R')
  end.min

  (row * 8) + column
end

sorted = ids.sort
sorted.each_with_index do |n, idx|
  next if idx == 0 || idx == sorted.size - 1
  next if (sorted[idx - 1] == n - 1) && (sorted[idx + 1] == n + 1)

  puts n
end
