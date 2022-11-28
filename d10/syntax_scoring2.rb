ERROR_SCORES = {
  ')' => 3,
  ']' => 57,
  '}' => 1197,
  '>' => 25_137
}.freeze

MATCH = {
  '(' => ')',
  '[' => ']',
  '{' => '}',
  '<' => '>'
}.freeze

COMPLETE_SCORES = {
  ')' => 1,
  ']' => 2,
  '}' => 3,
  '>' => 4
}.freeze

def find_incomplete(line)
  stack = []
  line.each_char do |chr|
    if MATCH[chr]
      stack << chr
    else
      return nil unless MATCH[stack.pop] == chr
    end
  end
  stack.reverse
end

def calc_score(incomplete)
  score = 0
  incomplete.each do |chr|
    score *= 5
    score += COMPLETE_SCORES[MATCH[chr]]
  end
  score
end

filename = 'input.txt'
scores = []
File.foreach(filename) do |line|
  incomplete = find_incomplete(line.chomp)
  scores << calc_score(incomplete) unless incomplete.nil?
end

puts scores.sort[scores.length / 2]
