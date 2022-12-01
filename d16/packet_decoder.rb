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

# Takes in packet, returns [value, bits travelled]
class PacketAnalyzer
  def initialize(packet)
    @packet = packet
    @idx = 0
    @total_ver_num = 0
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

  def len_limit
    len = 0
    until len >= @total_len
      _val, travelled, total_ver = PacketAnalyzer.new(@packet[@idx..]).run
      @total_ver_num += total_ver
      len += travelled
      @idx += travelled
    end
    ['No val', @idx, @total_ver_num]
  end

  def num_limit
    limit = 0
    until limit >= @num_subpackets
      _val, travelled, total_ver = PacketAnalyzer.new(@packet[@idx..]).run
      @total_ver_num += total_ver
      @idx += travelled
      limit += 1
    end
    ['No val', @idx, @total_ver_num]
  end

  def literal_value
    value = ''
    loop do
      continue = current
      value << @packet[@idx + 1...@idx + 5]
      @idx += 5
      break if continue == '0'
    end
    [value.to_i(2), @idx, @total_ver_num]
  end

  def parse_header
    @version = @packet[0...3].to_i(2)
    @total_ver_num += @version
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
