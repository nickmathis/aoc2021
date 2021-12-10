require '../aoc_base'

class Day6 < AocBase
  def initialize(filename)
    super(filename)
    @fish = @data.first.split(',').collect(&:to_i)
    puts @fish.inspect
  end

  def run_1
    map = {}
    6.times do |i|
      map[i+1] = run_for_days(80, [i+1])
    end
    @fish.inject(0) {|sum, i| sum + map[i] }
  end

  def run_2
    map = {}
    6.times do |i|
      map[i+1] = run_for_days(129, [i+1])
    end
    puts map.inspect

    @fish.inject(0) {|sum, i| sum + map[i] }
  end

  def run_for_days(days, fish)
    days.times.each do |day|
      new_fish = []
      fish.each_with_index do |f, i|
        if f > 0
          new_fish << f - 1
        else
          new_fish << 6
          new_fish << 8
        end
      end
      fish = new_fish
    end
    fish.count
  end
end

# puts Day6.new('test.txt').run_1
# puts Day6.new('data.txt').run_1
puts Day6.new('test.txt').run_2
# puts Day6.new('data.txt').run_2
