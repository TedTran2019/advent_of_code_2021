# 1 uses 2 letters
# 4 uses 4 letteres
# 7 uses 3 letters
# 8 uses 7 letters
# 0, 6, 9 uses 6 letters
# If 4.subset? out then 9
# elsif 7.subset out then 0
# else 6
# 2, 3, 5 uses 5 letters
# If 7.subset? out then 3
# elsif out - 4 == 2 then 5
# else 2
require 'set'

def map_signals(signals)
  store_signals = {}
  signals.split(' ').each do |signal|
    next unless [2, 4, 3, 7].include? signal.length

    store_signals[signal.length] = signal.split('').to_set
  end
  store_signals
end

def convert_five(output, signal)
  output = output.split('').to_set
  if signal[3].subset? output
    3
  elsif (output - signal[4]).length == 2
    5
  else
    2
  end
end

def convert_six(output, signal)
  output = output.split('').to_set
  if signal[4].subset? output
    9
  elsif signal[3].subset? output
    0
  else
    6
  end
end

filename = 'input.txt'
sum = 0
File.foreach(filename) do |line|
  signals, outputs = line.chomp.split(' | ')
  signals = map_signals(signals)
  outputs = outputs.split(' ')
  value = 0
  outputs.each do |output|
    case output.length
    when 2
      value = (value * 10) + 1
    when 4
      value = (value * 10) + 4
    when 3
      value = (value * 10) + 7
    when 7
      value = (value * 10) + 8
    when 5
      value = (value * 10) + convert_five(output, signals)
    when 6
      value = (value * 10) + convert_six(output, signals)
    end
  end
  sum += value
end

puts sum
