filename = 'input.txt'
increases = 0
prev_val = nil
File.foreach(filename) do |line|
  value = line.to_i

  if prev_val.nil?
    prev_val = value
    next
  end

  increases += 1 if value > prev_val
  prev_val = value
end

puts increases
