require_relative 'display'
require_relative 'board'
require_relative 'player'

class Game
attr_reader :board

  def initialize(player1, player2, board = Board.new)
    @player1 = player1
    @player2 = player2
    @board = board
    @display = Display.new(@board)
    @player1.load_info(:light_white, @display, @board)
    @player2.load_info(:black, @display, @board)
    @moves = 0
  end

  def play
    player1_checkmate = false
    player2_checkmate = false
    stalemate = false
    loop do
      move = @player1.play_turn
      promotion_check = @board.move(move[0], move[1])
      @player1.promotion(move[1]) if promotion_check
      player1_checkmate = @board.checkmate?(:black)
      stalemate = @board.stalemate?(:black)
      break if player1_checkmate || stalemate
      move = @player2.play_turn
      promotion_check = @board.move(move[0], move[1])
      @player2.promotion(move[1]) if promotion_check
      player2_checkmate = @board.checkmate?(:light_white)
      stalemate = @board.stalemate?(:light_white)
      stalemate = true if @moves > 200
      break if player2_checkmate || stalemate
      @moves += 1
    end
    system "clear"
    @display.render
    puts "CHECKMATE, #{@player1.name} wins!" if player1_checkmate
    puts "CHECKMATE, #{@player2.name} wins!" if player2_checkmate
    puts "STALEMATE" if stalemate
  end

end

puts "WELCOME TO CHESS!!!!"
puts "Player 1 please enter your name"
puts "If you want to play against computer type 'computer'"
name1 = gets.chomp
puts "Player 2 please enter your name"
puts "If you want to play against computer type 'computer'"
name2 = gets.chomp
if name1 == "computer"
  player1 = ComputerPlayer.new("Watson")
else
  player1 = HumanPlayer.new(name1)
end
if name2 == "computer"
  player2 = ComputerPlayer.new("Deep Blue")
else
  player2 = HumanPlayer.new(name2)
end


game = Game.new(player1, player2)
game.play
