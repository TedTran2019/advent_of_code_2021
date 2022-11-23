filename = 'input.txt'
depth = 0
horiz = 0
aim = 0
File.foreach(filename) do |line|
  cmd, nbr = line.split(' ')
  nbr = nbr.to_i

  case cmd
  when 'forward'
    horiz += nbr
    depth += aim * nbr
  when 'down'
    aim += nbr
  when 'up'
    aim -= nbr
  end
end

puts depth * horiz