filename = 'input.txt'
store = Hash.new { |h, k| h[k] = [0, 0] }
File.foreach(filename) do |line|
  line.chomp.each_char.with_index { |char, idx| store[idx][char.to_i] += 1 }
end

gamma = ''
epsilon = ''
store.each do |_k, v|
  if v[0] >= v[1]
    gamma << '0'
    epsilon << '1'
  else
    gamma << '1'
    epsilon << '0'
  end
end

puts gamma.to_i(2) * epsilon.to_i(2)
