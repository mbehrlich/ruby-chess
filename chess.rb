require_relative 'display'
require_relative 'board'
require_relative 'player'

class Game
attr_reader :board

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @board = Board.new
    @display = Display.new(@board)
    @player1.load_info(:light_white, @display, @board)
    @player2.load_info(:black, @display, @board)
  end

  def play
    loop do
      move = @player1.play_turn
      @board.move(move[0], move[1])
      break if @board.checkmate?(:black)
      move = @player2.play_turn
      @board.move(move[0], move[1])
      break if @board.checkmate?(:light_white)
    end
    system "clear"
    @display.render
    puts "CHECKMATE"
  end


end

game = Game.new(HumanPlayer.new("Colby"), HumanPlayer.new("Matthew"))
game.play
