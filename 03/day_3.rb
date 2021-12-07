require '../aoc_base'

class Day3 < AocBase
  def run_1
    bit_count = {}
    @data.each do |i|
      i.split('').each_with_index do |e, pos|
        puts e, pos
        bit_count[pos] ||= {0 =>  0, 1 => 0}
        bit_count[pos][e.to_i] += 1
      end
    end

    puts bit_count.inspect
  end

  def run_2
    bit_count = {}
    @data.each do |i|
      i.split('').each_with_index do |e, pos|
        puts e, pos
        bit_count[pos] ||= {0 =>  0, 1 => 0}
        bit_count[pos][e.to_i] += 1
      end
    end
    # no idea
    @data.each do |i|
      i.split('').each_with_index do |e, pos|
        if bit_count[pos]
        end
      end
    end

  end
end

# puts Day3.new('test.txt').run_1
# puts Day3.new('data.txt').run_1
puts Day3.new('test.txt').run_2
# puts Day3.new('data.txt').run_2

110111000111 => 3527
001000111000 =? 568
