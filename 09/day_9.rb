require '../aoc_base'

class Day9 < AocBase
  def initialize(filename)
    super(filename)

    @map = []
    @data.each do |r|
      @map << r.split('')
    end

    @map.each { |i| puts i.inspect }
  end

  def run_1
    @lowest_points = []
    @lowest_points_debug = []

    @map.each_with_index do |row, a|
      row.each_with_index do |item, b|
        # bounds check and next if it's not lowest point
        # puts "next if #{a} > 0 && #{item} > #{@map[a-1][b]}"
        # puts "next if #{b} > 0 && #{item} > #{@map[a][b-1]}"
        # puts "next if #{b} < (#{row.size} - 1) && #{item} > #{@map[a][b+1]}"
        # puts "next if #{a} < (#{@map.size} - 1) && #{item} > #{@map[a+1][b]}"

        next if a > 0 && item >= @map[a-1][b] # up
        next if b > 0 && item >= @map[a][b-1] # left
        next if b < row.size - 1 && item >= @map[a][b+1] # right
        next if a < @map.size - 1 && item >= @map[a+1][b] #down
        puts "**** lowest point (#{item}) found at [#{a}][#{b}] **** "
        @lowest_points << item.to_i + 1
        @lowest_points_debug << [item.to_i + 1, a, b]
      end
    end

    @lowest_points_debug.each { |row| puts row.inspect }
    @lowest_points.inject(:+)  #+ @lowest_points.size
  end


  def run_2

  end


end

# puts Day9.new('test.txt').run_1
puts Day9.new('data.txt').run_1
# puts Day9.new('test.txt').run_2
# puts Day9.new('data.txt').run_2

