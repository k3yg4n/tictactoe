# frozen_string_literal: true

# This class is used to contain methods and variables for the two players
class Player
  attr_reader :symbol, :name

  @@num_players = 0

  def initialize(name)
    @name = name
    @symbol = @@num_players.zero? ? 'o' : 'x'
    @@num_players += 1
  end

  def play(position, board)
    cell_contents = board.board_array[position]
    symbols_array = %w[o x]
    while symbols_array.include?(cell_contents)
      puts 'Please enter a valid position that has not been populated.'
      position = get_position(self) - 1
      cell_contents = board.board_array[position]
    end
    board.board_array[position] = @symbol
    board.display_board
  end
end

# This class is used to contain methods and variables for the tic-tac-toe board
class Board
  attr_accessor :board_array

  private

  def initialize
    @board_array = [1, 2, 3, 4, 5, 6, 7, 8, 9]
  end

  public

  def display_board
    @board_array.each_with_index do |element, idx|
      idx_plus_one = idx + 1
      print "#{element} "
      print "\n" if (idx_plus_one % 3).zero?
    end
  end

  def reset_board
    for i in 0..8
      @board_array[i] = i + 1
    end
  end

  def won?(player)
    return false unless row_win?(player) || col_win?(player) || diag_win?(player)

    puts "The game is over! The winner is #{player.name}!"
    true
  end

  # This method returns true if there is a win in any row
  def row_win?(player)
    symbol = player.symbol
    i = 0
    while i <= 6
      return true if @board_array[i] == symbol && @board_array[i + 1] == symbol && @board_array[i + 2] == symbol

      i += 3
    end
    false
  end

  # This method returns true if there is a win in any column
  def col_win?(player)
    symbol = player.symbol
    i = 0
    while i <= 3
      return true if @board_array[i] == symbol && @board_array[i + 3] == symbol && @board_array[i + 6] == symbol

      i += 1
    end
    false
  end

  # This method returns true if there is a diagonal win
  def diag_win?(player)
    symbol = player.symbol
    return true if @board_array[0] == symbol && @board_array[4] == symbol && @board_array[8] == symbol
    return true if @board_array[2] == symbol && @board_array[4] == symbol && @board_array[6] == symbol

    false
  end
end

def get_position(player)
  position = -1
  until position.between?(1, 9)
    print "#{player.name}, select a position (1-9) to place your symbol(#{player.symbol}): "
    position = gets.chomp.to_i
  end
  position
end

puts 'Welcome to Tic-Tac-Toe!'
puts 'Two players take turns marking the spaces in a three-by-three grid with "x" or "o". The player who succeeds in'\
      'placing three of their marks in a horizontal, vertical, or diagonal row is the winner.'
print 'Player 1, enter your name: '
player_one_name = gets.chomp
print 'Player 2, enter your name: '
player_two_name = gets.chomp

# Intialize initial gamestate
player1 = Player.new(player_one_name)
player2 = Player.new(player_two_name)
my_board = Board.new

continue = true
while continue == true
  my_board.reset_board
  my_board.display_board
  p1_turn = true
  position_idx = -1

  while my_board.won?(player1) == false && my_board.won?(player2) == false
    if p1_turn
      position_idx = get_position(player1) - 1
      player1.play(position_idx, my_board)
      p1_turn = false
    else
      position_idx = get_position(player2) - 1
      player2.play(position_idx, my_board)
      p1_turn = true
    end
  end
  response = ''
  while response != 'Y' && response != 'N'
    print 'Enter Y to play again and N to quit: '
    response = gets.chomp.upcase
    puts "\n"
    continue = (response == 'Y')
  end
end
