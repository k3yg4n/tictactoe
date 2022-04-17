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

  def won?(player)
    return false unless row_win?(player) || col_win?(player) || diag_win?(player)

    puts "The game is over! The winner is #{player.name}"
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

continue = true
while continue == true
  puts 'Welcome to Tic-Tac-Toe!'
  puts 'Two players take turns marking the spaces in a three-by-three grid with "x" or "o". The player who succeeds in
        placing three of their marks in a horizontal, vertical, or diagonal row is the winner.'
  print 'Player 1, enter your name: '
  player_one_name = gets.chomp
  print 'Player 2, enter your name: '
  player_two_name = gets.chomp

  # Intialize initial gamestate
  player1 = Player.new(player_one_name)
  player2 = Player.new(player_two_name)
  my_board = Board.new
  my_board.display_board
  p1_turn = true

  while my_board.won?(player1) == false && my_board.won?(player2) == false
    if p1_turn
      print "#{player1.name}, select a position (1-9) to place your symbol(o): "
      position = gets.chomp.to_i - 1
      player1.play(position, my_board)
      p1_turn = false
    else
      print "#{player2.name}, select a position (1-9) to place your symbol(o): "
      position = gets.chomp.to_i - 1
      player2.play(position, my_board)
      p1_turn = true
    end
  end
  response = ''
  while response != 'Y' && response != 'N'
    print 'Enter Y to play again and N to quit:'
    response = gets.chomp.upcase
    continue = (response == 'Y')
  end
end
