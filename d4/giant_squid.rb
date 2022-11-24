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

def find_winner(boards, numbers)
  numbers.each do |target|
    boards.each do |board|
      mark_board(board, target)
      return [board, target] if winner?(board)
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

winning_board, winning_nbr = find_winner(boards, input)
puts sum_board(winning_board) * winning_nbr.to_i
