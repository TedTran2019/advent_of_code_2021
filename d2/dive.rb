filename = 'input.txt'
depth = 0
horiz = 0
File.foreach(filename) do |line|
  cmd, nbr = line.split(' ')
  nbr = nbr.to_i

  case cmd
  when 'forward'
    horiz += nbr
  when 'down'
    depth += nbr
  when 'up'
    depth -= nbr
  end
end

puts depth * horiz
