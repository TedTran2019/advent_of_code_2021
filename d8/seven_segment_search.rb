# 1 uses 2 letters
# 4 uses 4 letteres
# 7 uses 3 letters
# 8 uses 7 letters

filename = 'input.txt'
uniq_segments = 0
uniq = [2, 4, 3, 7]
File.foreach(filename) do |line|
  _signals, outputs = line.chomp.split(' | ')
  outputs = outputs.split(' ')
  uniq_segments += outputs.count { |output| uniq.include?(output.length) }
end

puts uniq_segments
