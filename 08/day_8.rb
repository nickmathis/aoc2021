require '../aoc_base'

class Day8 < AocBase
  def initialize(filename)
    super(filename)
    @data.collect!{|e| e.split(' | ')}
    @mappings = {}
    @input_mapping = { }

    @baseline = {
      0 => 'abcefg',
      1 => 'cf',
      2 => 'acdeg',
      3 => 'acdfg',
      4 => 'bcdf',
      5 => 'abdfg',
      6 => 'abdefg',
      7 => 'acf',
      8 => 'abcdefg',
      9 => 'abcdfg'
    }
    @new_mapping = { }

    @baseline.each do |a, b|
      @new_mapping[a] = ''
      b.split('').each do |i|
        @new_mapping[a] << @input_mapping[i.to_sym].to_s
      end

      @new_mapping[a] = @new_mapping[a].chars.sort.join
    end

  end

  def run_1
    # map_1 # cf, abdeg
    # map_4 # bcdf => bcdf
    # map_7 # acf => abcdf
    # map_8 # abcdefg 9?
    count = 0
    @data.each do |i|
      i.last.split(' ').each do |e|
        # puts "e: #{e}, e.size: #{e.size}"
        count += 1 if [2, 3, 4, 7].include?(e.size)
      end
    end
    puts count
  end

  def run_2
    sum = 0
    @data.each do |row|
      build_map(row.first.split(' '))
      return
      number = ''
      row.last.split(' ').each do |e|
        # puts "e: #{e}, e.size: #{e.size}"
        @new_mapping.each do |a, b|
          puts "#{number} << #{a} if #{b} == #{e.chars.sort.join}"
          number << a.to_s if b == e.chars.sort.join
        end
        puts number
      end
      sum += number.to_i
    end
    puts sum
  end

  def build_map(row)
    map_1(row)
    map_7(row)
    map_4(row)
    map_5(row)
  end

  def map_1(row)
    @mappings[1] = row.find{|i| i.size == 2}.split('')
    # puts @mappings.inspect
  end

  def map_7(row)
    @mappings[7] = row.find{|i| i.size == 3}.split('')
    # puts @mappings.inspect
    # we know a (7 - 1)
    @input_mapping['a'] = (@mappings[7] - @mappings[1])[0]
    # puts @input_mapping.inspect
  end

  def map_4(row)
    # we have b, d theories
    @mappings[4] = row.find{|i| i.size == 4}.split('')
    # puts @mappings.inspect

  end

  def map_5(row)
    # look for things we know
    options = [
      @input_mapping['a'] + (@mappings[4] - @mappings[1]).join + @mappings[1].first,
      @input_mapping['a'] + (@mappings[4] - @mappings[1]).join + @mappings[1].last
    ]

    @mappings[5] = row.find do |i|
      if(i.size == 5)
        options.each do |candidate|
          i if i.split('') - candidate.split('') == 1
        end
      end
    end.split('')

    puts @mappings.inspect
    # we know b, f, g (b = seen in 4, f = seen in 7, g = new one we've not seen from 1, 4, 7)
    @input_mapping['b'] = (@mappings[5] - @mappings[7]) # & @mappings[4]
    @input_mapping['f'] = (@mappings[5] & @mappings[7]) - [@input_mapping['a']]
    @input_mapping['g'] = @mappings[5] - @mappings[7] - @mappings[4]
    # we know d, missing pair from 4, we know c, missing pair from 7
    @input_mapping['d'] = @mappings[4] - [@input_mapping['b']]
    @input_mapping['c'] = @mappings[7] - [@input_mapping['b']] - [@input_mapping['a']]
    # a, b, c, d, f, g mapped
    # e is left, and implied
    @input_mapping['e'] = ['a', 'b', 'c', 'd', 'e', 'f', 'g'] - @input_mapping.keys
    puts @input_mapping.inspect
  end
end

# puts Day8.new('test.txt').run_1
# puts Day8.new('data.txt').run_1
puts Day8.new('test.txt').run_2
# puts Day8.new('data.txt').run_2

