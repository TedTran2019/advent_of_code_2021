filename = 'input.txt'
store = [0, 0]
orig = []
File.foreach(filename) do |line|
  line.chomp!
  store[line[0].to_i] += 1
  orig << line
end

def count_from_array_max(arr, idx)
  count = [0, 0]
  arr.each do |line|
    count[line[idx].to_i] += 1
  end
  count[0] > count[1] ? '0' : '1'
end

def count_from_array_min(arr, idx)
  count = [0, 0]
  arr.each do |line|
    count[line[idx].to_i] += 1
  end
  count[0] > count[1] ? '1' : '0'
end

def generator_rating(orig, filter, idx)
  return orig if orig.size == 1

  new_arr = orig.filter { |line| line[idx] == filter }
  new_filter = count_from_array_max(new_arr, idx + 1)
  generator_rating(new_arr, new_filter, idx + 1)
end

def scrubber_rating(orig, filter, idx)
  return orig if orig.size == 1

  new_arr = orig.filter { |line| line[idx] == filter }
  new_filter = count_from_array_min(new_arr, idx + 1)
  scrubber_rating(new_arr, new_filter, idx + 1)
end

filter_max = store[0] > store[1] ? '0' : '1'
filter_min = store[0] > store[1] ? '1' : '0'
gen = generator_rating(orig, filter_max, 0).join('').to_i(2)
scrub = scrubber_rating(orig, filter_min, 0).join('').to_i(2)
puts gen * scrub
