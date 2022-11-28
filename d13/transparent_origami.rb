filename = 'input.txt'
coors = []
folds = []
File.foreach(filename) do |line|
  next if line == "\n"

  line.chomp!
  if line.start_with? 'f'
    fold = line.split(' ')[2].split('=')
    fold[1] = fold[1].to_i
    folds << fold
  else
    coors << line.split(',').map(&:to_i)
  end
end

def boundaries(coors)
  max_x = 0
  max_y = 0
  coors.each do |x, y|
    max_x = x if x > max_x
    max_y = y if y > max_y
  end
  [max_x, max_y]
end

def create_new_array(coors)
  x, y = boundaries(coors)
  paper = Array.new(y + 1) { Array.new(x + 1, '.') }
  coors.each do |coor|
    cx = coor[0]
    cy = coor[1]
    paper[cy][cx] = '#'
  end
  paper
end

def display_paper(paper)
  paper.each do |row|
    row.each { |el| print el }
    puts
  end
end

def fold_up(paper, fold)
  bottom = paper.slice!(fold, paper.length - 1)
  bottom.shift
  bottom.each do |row|
    fold -= 1
    row.each_with_index do |el, x|
      paper[fold][x] = '#' if el == '#'
    end
  end
  paper
end

def fold_left(paper, fold)
  paper.length.times do |y|
    right = paper[y].slice!(fold, paper[y].length - 1)
    right.shift
    x = fold
    right.each do |el|
      x -= 1
      paper[y][x] = '#' if el == '#'
    end
  end
  paper
end

def count_dots(paper)
  paper.inject(0) { |sum, row| sum + row.count { |el| el == '#' } }
end

paper = create_new_array(coors)
paper = fold_left(paper, 655)
puts count_dots(paper)
