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
  end

  def play
    loop do
      move = @player1.play_turn
      @board.move(move[0], move[1])
      player1_checkmate = @board.checkmate?(:black)
      stalemate = @board.stalemate?(:black)
      break if player1_checkmate || stalemate
      move = @player2.play_turn
      @board.move(move[0], move[1])
      player2_checkmate = @board.checkmate?(:light_white)
      stalemate = @board.stalemate?(:light_white)
      break if player2_checkmate || stalemate
    end
    system "clear"
    @display.render
    puts "CHECKMATE, #{@player1.name} wins!" if player1_checkmate
    puts "CHECKMATE, #{@player2.name} wins!" if player2_checkmate
    puts "STALEMATE" if stalemate
  end


end

START_BOARD_1 = [Rook.new(:black), Knight.new(:black), Bishop.new(:black), Queen.new(:black), King.new(:black), Bishop.new(:black), Knight.new(:black), Rook.new(:black)]
START_BOARD_2 = [Pawn.new(:black), Pawn.new(:black), Pawn.new(:black), Pawn.new(:black), Pawn.new(:black), Pawn.new(:black), Pawn.new(:black), Pawn.new(:black)]
START_BOARD_3 = Array.new(8, NullPiece.instance)
START_BOARD_4 = Array.new(8, NullPiece.instance)
START_BOARD_5 = Array.new(8, NullPiece.instance)
START_BOARD_6 = Array.new(8, NullPiece.instance)
START_BOARD_7 = [Pawn.new(:light_white), Pawn.new(:light_white), Pawn.new(:light_white), Pawn.new(:light_white), Pawn.new(:light_white), Pawn.new(:light_white), Pawn.new(:light_white), Pawn.new(:light_white)]
START_BOARD_8 = [Rook.new(:light_white), NullPiece.instance, NullPiece.instance, NullPiece.instance, King.new(:light_white), NullPiece.instance, NullPiece.instance, Rook.new(:light_white)]
START_BOARD = [START_BOARD_1, START_BOARD_2, START_BOARD_3, START_BOARD_4, START_BOARD_5, START_BOARD_6, START_BOARD_7, START_BOARD_8]


game = Game.new(HumanPlayer.new("Colby"), HumanPlayer.new("Matthew"), Board.new(START_BOARD))
game.play
