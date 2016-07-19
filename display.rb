require_relative 'board'
require_relative 'cursorable'
require 'colorize'

class Display
  include Cursorable

  attr_reader :board

  def initialize(board)
    @board = board
    @cursor_pos = [0, 0]
  end

  def cursor_move(message1, message2)
    system "clear"
    puts message1
    puts message2
    render
    until get_input == @cursor_pos
      system "clear"
      puts message1
      puts message2
      render
    end
    @cursor_pos
  end

  def render
    print "\n"
    @board.grid.each_with_index do |row, row_index|
      row.each_with_index do |col, col_index|
        pos = [row_index, col_index]
        bg_color = row_index.even? && col_index.even? || row_index.odd? && col_index.odd? ? (:blue) : (:green)
        bg_color = :red if pos == @cursor_pos
        print @board[pos].to_s.colorize(:color => @board[pos].color, :background => bg_color)
      end
      print "\n"
    end

  end
end

# a = Display.new(Board.new([[ Pawn.new(:white), NullPiece.instance, NullPiece.instance, NullPiece.instance], [Bishop.new(:white), NullPiece.instance, Rook.new(:black), NullPiece.instance], [NullPiece.instance, King.new(:white), NullPiece.instance, NullPiece.instance], [NullPiece.instance, NullPiece.instance, NullPiece.instance, NullPiece.instance]]))
# a.cursor_move
# p a.board[[2,1]].valid_moves
