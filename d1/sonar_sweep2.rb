filename = 'input.txt'
increases = 0
window = []
sum = 0
increases = 0
File.foreach(filename) do |line|
  value = line.to_i
  if window.length < 3
    window << value
    sum += value
  else
    new_sum = sum - window.shift
    window << value
    new_sum += value
    increases += 1 if new_sum > sum
    sum = new_sum
  end
end

puts increases
