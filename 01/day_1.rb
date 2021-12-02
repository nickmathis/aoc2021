require '../aoc_base'

class Day1 < AocBase
  def run_1
    count_increases(@data)
  end

  def run_2
    count_increases(group_data(@data))
  end

  def count_increases(data)
    prev = nil
    count = 0
    data.each do |elem|
      count += 1 if prev && elem > prev
      prev = elem
    end
    count
  end

  def group_data(data)
    grouped = []
    data.each_with_index do |_e, i|
      break if i + 2 >= data.size
      grouped << [data[i], data[i+1], data[i+2]]
    end
    grouped.collect {|i| i.inject(:+)}
  end

end

puts Day1.new('test.txt', integers: true).run_2
