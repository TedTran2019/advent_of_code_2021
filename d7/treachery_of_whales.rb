def fuel_to_align(positions, align_pos)
  positions.inject(0) { |fuel, pos| fuel + (pos - align_pos).abs }
end

filename = 'input.txt'
positions = nil
File.foreach(filename) do |line|
  positions = line.chomp.split(',').map(&:to_i)
end
min = positions.min
max = positions.max

min_fuel = nil
min.upto(max) do |align_pos|
  if min_fuel.nil?
    min_fuel = fuel_to_align(positions, align_pos)
  else
    fuel = fuel_to_align(positions, align_pos)
    min_fuel = fuel if min_fuel > fuel
  end
end

puts min_fuel
