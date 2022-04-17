# frozen_string_literal: true

# This class is used to contain methods and variables for the two players
class Player
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

  def check_win
    p 'The game is over! Enter Y to play again and N to quit.' if won?
  end

  def won?
    p(self)
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

  # TESTING #
  player_one_name = 'p1'
  player_two_name = 'p2'
  ###########

  # Intialize initial gamestate
  player1 = Player.new(player_one_name)
  player2 = Player.new(player_two_name)
  my_board = Board.new
  my_board.display_board
  p1_turn = true

  while my_board.won? == false
    if p1_turn
      print 'Player 1 (o), select a position: '
      position = gets.chomp.to_i
      player1.play(position, my_board)
      p1_turn = false
    else
      print 'Player 2 (x), select a position: '
      position = gets.chomp.to_i
      player2.play(position, my_board)
      p1_turn = true
    end
  end
  p 'Game has ended. Enter "Y" to play again and "N" to quit.'
  response = gets.chomp.upcase
  continue = (response == 'Y')
end
