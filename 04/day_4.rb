require '../aoc_base'

class Day4 < AocBase
  def initialize(filename)
    super(filename)
    @numbers = @data.shift.split(',')
    @winning_boards = []
    load_boards
  end

  def run_1
    @numbers.each do |number|
      if winning_board = check_number(number)
        return calculate_winner_score(winning_board, number)
      end
    end
    'no winner found'
  end

  def check_number(number)
    winning_board = nil
    @boards.each_with_index do |board, b_i|
      puts "trying #{number} in #{board.inspect}"

      board.each_with_index do |row, r_i|
        row.each_with_index do |item, i_i|

          if item[0] == number
            puts "found #{number}"
            @boards[b_i][r_i][i_i][1] = 1
            if check_column(@boards[b_i], i_i) || check_row(@boards[b_i], r_i) || check_diagonals(@boards[b_i])
              puts @winning_boards.inspect
              if !@winning_boards.include?(b_i) # if has not won yet
                puts "first win for #{b_i}"
                @winning_boards << b_i
                winning_board = board
              end
            end
          end
        end
      end
    end

    return winning_board || false
  end

  def run_2
    last_score = 0
    @numbers.each do |number|
      if winning_board = check_number(number)
        puts "Winner found #{winning_board.inspect}"
        last_score = calculate_winner_score(winning_board, number)
        puts last_score
      end
    end
    last_score
  end

  def load_boards
    @boards = []
    board_number = -1
    
    @data.each do |row|
      if row == ""
        board_number += 1 
        @boards[board_number] = []
        next
      end
      @boards[board_number] << row.split(' ').collect {|item| [item, 0]}
    end
  end

  def check_column(board, col)
    puts "trying #{board} at C#{col}" if @debug
    5.times do |i|
      return false if board[i][col].last == 0
    end
    puts "Winner #{board.inspect} #{col}" if @debug
    return 1
  end

  def check_row(board, row)
    puts "trying #{board} at R#{row}" if @debug
    5.times do |i|
      return false if board[row][i].last == 0
    end
    puts "Winner #{board.inspect} #{row}" if @debug
    return 1
  end

  def check_diagonals(board)
    puts "trying #{board} diagonals" if @debug
    5.times do |i|
      return false if board[i][i].last == 0
      return false if board[i][5-i-1].last == 0
    end
    puts "Winner #{board.inspect} (diagonal)" if @debug
    return 1
  end

  def calculate_winner_score(board, number)
    score = 0
    board.each {|r| r.each {|i| score += i.first.to_i if i.last == 0 } }
    score * number.to_i
  end
end

# puts Day4.new('test.txt').run_1
# puts Day4.new('data.txt').run_1
# puts Day4.new('test.txt').run_2
puts Day4.new('data.txt').run_2

