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

# Ignore incomplete
def calc_syntax_errors(line)
  stack = []
  error_score = 0
  line.each_char do |chr|
    if MATCH[chr]
      stack << chr
    else
      error_score += ERROR_SCORES[chr] unless MATCH[stack.pop] == chr
    end
  end
  error_score
end

filename = 'input.txt'
syntax_error_score = 0
File.foreach(filename) do |line|
  syntax_error_score += calc_syntax_errors(line.chomp)
end
puts syntax_error_score
