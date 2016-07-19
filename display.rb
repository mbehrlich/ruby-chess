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

  def cursor_move
    render
    until get_input == @cursor_pos
      system "clear"
      render
    end
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

a = Display.new(Board.new([[ NullPiece.instance, NullPiece.instance, NullPiece.instance, NullPiece.instance], [Bishop.new(:black), NullPiece.instance, Rook.new(:white), NullPiece.instance], [NullPiece.instance, Pawn.new(:white), NullPiece.instance, NullPiece.instance], [NullPiece.instance, NullPiece.instance, NullPiece.instance, NullPiece.instance]]))
a.cursor_move
p a.board[[2, 1]].moves
