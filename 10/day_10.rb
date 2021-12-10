require '../aoc_base'

class Day10 < AocBase
  def initialize(filename)
    super(filename)

    @opening_chars = ['(', '[', '{', '<']
    @char_pairs = {
      '(' => ')',
      '[' => ']',
      '{' => '}',
      '<' => '>'
    }

    @syntax_error_points = { ')' => 3, ']' => 57, '}' => 1197, '>' => 25137 }

    @incomplete_lines = []
    @autocomplete_points = { ')' => 1, ']' => 2, '}' => 3, '>' => 4 }
  end

  def run_1
    @syntax_errors = []
    @data.each do |row|
      @stack = []
      valid_row = true
      row.split('').each do |char|
        if @opening_chars.include?(char)
          # puts "#{char} is valid char for #{@stack.inspect}"
          @stack.push(char)
        elsif char == @char_pairs[@stack.last]
          # puts "#{char} is valid char for #{@stack.inspect}"
          @stack.pop
        else
          # puts "#{char} is invalid char for #{@stack.inspect}"
          @syntax_errors << char
          valid_row = false
          break
        end
      end
      if valid_row
        @incomplete_lines << row
        puts "***** row is valid *****"
      else
        puts "***** row is INVALID *****"
      end
    end
    # puts @syntax_errors.inspect
    calculate_error_score
  end

  def calculate_error_score
    @syntax_errors.inject(0) { |score, item| score + @syntax_error_points[item] }
  end

  def run_2
    run_1
    missing_pairs = @char_pairs.invert
    @autocomplete_lines = []

    @incomplete_lines.each_with_index do |row, i|
      @autocomplete_lines[i] = []
      @stack = []
      row.split('').each do |char|
        # create stack
        if @opening_chars.include?(char)
          @stack.push(char)
        else # match, so pop
          @stack.pop
        end
      end

      @stack.reverse!
      @stack.each do |char|
        # puts "found #{char}, needs #{@char_pairs[char]}"
        @autocomplete_lines[i] << @char_pairs[char]
      end
    end
    calculate_autocomplete_score
  end

  def calculate_autocomplete_score
    scores = []
    @autocomplete_lines.each do |line|
      scores << line.inject(0) { |i, item| 5*i + @autocomplete_points[item] }
    end
    scores.sort!
    scores[scores.size / 2]
  end


end

# puts Day10.new('test.txt').run_1
# puts Day10.new('data.txt').run_1
# puts Day10.new('test.txt').run_2
puts Day10.new('data.txt').run_2

