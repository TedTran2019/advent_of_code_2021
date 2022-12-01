def convert_to_dec(char)
  ascii = char.ord
  if ascii.between?(48, 57)
    ascii - 48
  else
    ascii - 55
  end
end

def convert_hex_to_binary(hex)
  binary_str = ''
  hex.each_char do |chr|
    dec = convert_to_dec((chr))
    binary_str << dec.to_s(2).rjust(4, '0')
  end
  binary_str
end

require 'byebug'
# Takes in packet, returns [value, bits travelled]
class PacketAnalyzer
  def initialize(packet)
    @packet = packet
    @idx = 0
    parse_header
  end

  def run
    case @type_id
    when 4
      literal_value
    else
      operator
    end
  end

  private

  def operator
    @op_type == '0' ? len_limit : num_limit
  end

  def operation(values)
    case @type_id
    when 0
      values.sum
    when 1
      values.inject(1) { |mult, el| mult * el }
    when 2
      values.min
    when 3
      values.max
    when 5
      values[0] > values[1] ? 1 : 0
    when 6
      values[0] < values[1] ? 1 : 0
    when 7
      values[0] == values[1] ? 1 : 0
    end
  end

  def len_limit
    len = 0
    values = []
    until len >= @total_len
      val, travelled = PacketAnalyzer.new(@packet[@idx..]).run
      values << val
      len += travelled
      @idx += travelled
    end
    final_val = operation(values)
    [final_val, @idx]
  end

  def num_limit
    limit = 0
    values = []
    until limit >= @num_subpackets
      val, travelled = PacketAnalyzer.new(@packet[@idx..]).run
      values << val
      @idx += travelled
      limit += 1
    end
    final_val = operation(values)
    [final_val, @idx]
  end

  def literal_value
    value = ''
    loop do
      continue = current
      value << @packet[@idx + 1...@idx + 5]
      @idx += 5
      break if continue == '0'
    end
    [value.to_i(2), @idx]
  end

  def parse_header
    @version = @packet[0...3].to_i(2)
    @type_id = @packet[3...6].to_i(2)
    @idx += 6
    parse_operator_type unless @type_id == 4
  end

  def parse_operator_type
    @op_type = current
    @idx += 1
    if @op_type == '0'
      @total_len = @packet[@idx...@idx + 15].to_i(2)
      @idx += 15
    else
      @num_subpackets = @packet[@idx...@idx + 11].to_i(2)
      @idx += 11
    end
  end

  def current
    @packet[@idx]
  end
end

filename = 'input.txt'
hex_string = nil
File.foreach(filename) do |line|
  hex_string = line.chomp
end

packet = convert_hex_to_binary(hex_string)
puts PacketAnalyzer.new(packet).run
