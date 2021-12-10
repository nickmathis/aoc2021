require '../aoc_base'

class Day3 < AocBase
  def run_1
    vals = []
    size = nil

    # count 1 or 0 per position
    @data.each do |elem|
      size ||= elem.size

      elem.split('').each_with_index do |e, i|
        vals[i] ||= { '0' => 0, '1'=> 0}
        vals[i][e] += 1
      end

    end

    most = vals.collect {|i| i['0'] > i['1'] ? '0' : '1'}.join
    # create the "most" string
    most = most.to_i(2)
    least = 2**size - 1 - most
    most * least
  end

  def run_2

  end

end

puts Day3.new('data.txt').run_1
