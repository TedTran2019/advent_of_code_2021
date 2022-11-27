def pass_day(time_count)
  new_count = Array.new(9, 0)
  time_count.each_with_index do |time, idx|
    if idx.zero?
      new_count[6] += time
      new_count[8] += time
    else
      new_count[idx - 1] += time
    end
  end
  new_count
end

filename = 'input.txt'
timers = nil
time_count = Array.new(9, 0)
File.foreach(filename) { |line| timers = line.chomp.split(',').map(&:to_i) }
timers.each { |time| time_count[time] += 1 }
# 80.times { time_count = pass_day(time_count) }
256.times { time_count = pass_day(time_count) }
puts time_count.sum
