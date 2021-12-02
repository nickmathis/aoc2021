require '../aoc_base'

class Day2 < AocBase
  def run_1
    x = 0
    y = 0
    @data.each do |i|
      vals = i.split
      if vals.first == 'forward'
        x += vals.last.to_i
      elsif vals.first == 'down'
        y -= vals.last.to_i
      else
        y += vals.last.to_i
      end
    end
    puts x*y
  end

  def run_2
    aim = 0
    x = 0
    y = 0
    @data.each do |i|
      vals = i.split
      if vals.first == 'forward'
        x += vals.last.to_i
        y += aim * vals.last.to_i
      elsif vals.first == 'down'
        aim -= vals.last.to_i
      else
        aim += vals.last.to_i
      end
    end
    puts x*y
  end

end

puts Day2.new('data.txt').run_2
