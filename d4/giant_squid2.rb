filename = 'input.txt'
boards = []
input = nil
new_board = nil
File.foreach(filename).with_index do |line, idx|
  line.chomp!
  if idx.zero?
    input = line.split(',')
    next
  end

  if line.empty?
    boards << new_board unless idx == 1
    new_board = []
  else
    new_board << line.split(' ')
  end
end

def find_loser(boards, numbers)
  won_boards = 0
  numbers.each do |target|
    boards.each_with_index do |board, idx|
      next if board.nil?

      mark_board(board, target)
      next unless winner?(board)

      won_boards += 1
      return [board, target] if won_boards == boards.length

      boards[idx] = nil
    end
  end
end

def winner?(board)
  won_row?(board) || won_col?(board)
end

def won_row?(board)
  board.any? { |row| row.all? { |nbr| nbr == 'X' } }
end

def won_col?(board)
  won_row?(board.transpose)
end

def mark_board(board, target)
  board.each_with_index do |row, y|
    row.each_with_index do |el, x|
      if el == target
        board[y][x] = 'X'
        return
      end
    end
  end
end

def sum_board(board)
  board.inject(0) { |total, row| total + row.inject(0) { |sum, el| sum + (el == 'X' ? 0 : el.to_i) } }
end

losing_board, losing_nbr = find_loser(boards, input)
puts sum_board(losing_board) * losing_nbr.to_i
