def step(template_count, insertion_rules)
  new_count = template_count.clone
  template_count.each do |k, v|
    next if v.zero?
    next unless insertion_rules[k]

    letter = insertion_rules[k]
    split = k.split('')
    first = split[0] + letter
    second = letter + split[1]

    new_count[first] += v
    new_count[second] += v
    new_count[k] -= v
  end
  new_count
end

# One isolated letter is left (the final letter of original polymer template)
def convert_template_to_hash(template)
  count = Hash.new(0)
  (0...template.length - 1).each do |idx|
    count[template[idx..idx + 1]] += 1
  end
  count[template[-1]] += 1 # Isolated non-paired character added here
  count
end

def sub_most_and_least_common(template_count)
  count = Hash.new(0)
  template_count.each do |k, v|
    next if v.zero?

    first, _second = k.split('')
    count[first] += v
  end
  count.values.max - count.values.min
end

filename = 'input.txt'
template = nil
insertion_rules = {}
File.foreach(filename).with_index do |line, idx|
  next if line == "\n"

  line = line.chomp!
  if idx.zero?
    template = line
    next
  end
  pair, letter = line.split(' -> ')
  insertion_rules[pair] = letter
end

template_count = convert_template_to_hash(template)
40.times { template_count = step(template_count, insertion_rules) }
puts sub_most_and_least_common(template_count)
