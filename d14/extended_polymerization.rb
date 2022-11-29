class LinkedList
  attr_reader :head, :tail

  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next = @tail
    @tail.prev = @head
  end

  def push(val)
    new_node = Node.new(val)
    last_node = @tail.prev
    last_node.next = new_node
    new_node.prev = last_node
    new_node.next = @tail
    @tail.prev = new_node
  end

  def pop
    return nil if @head.next == @tail

    before_last_node = @tail.prev.prev
    before_last_node.next = @tail
    @tail.prev = before_last_node
  end

  def to_s
    str = ''
    start = @head.next
    until start == @tail
      str << start.val
      start = start.next
    end
    str
  end

  def first
    return nil if @head.next == @tail

    @head.next
  end
end

class Node
  attr_accessor :val, :next, :prev

  def initialize(val = nil)
    @val = val
    @next = nil
    @prev = nil
  end

  def add(val)
    new_node = Node.new(val)
    next_node = @next
    @next = new_node
    new_node.prev = self
    new_node.next = next_node
    next_node.prev = new_node
  end
end

def convert_to_linked_list(template)
  list = LinkedList.new
  template.each_char { |chr| list.push(chr) }
  list
end

def step(template_list, rules)
  start = template_list.first
  return nil if start.nil?

  until start.next.val.nil?
    next_node = start.next

    add_poly = rules["#{start.val}#{next_node.val}"]
    if add_poly
      start.add(add_poly)
      start = start.next
    end
    start = start.next
  end
end

def sub_most_and_least_common(str)
  count = Hash.new(0)
  str.each_char { |chr| count[chr] += 1 }
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

template_list = convert_to_linked_list(template)
10.times { step(template_list, insertion_rules) }
template_str = template_list.to_s
puts sub_most_and_least_common(template_str)
