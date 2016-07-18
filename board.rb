require_relative 'piece'
require_relative 'null_piece'



class Board
  START_BOARD_1 = [Piece.new, Piece.new, Piece.new, Piece.new, Piece.new, Piece.new, Piece.new, Piece.new]
  START_BOARD_2 = [Piece.new, Piece.new, Piece.new, Piece.new, Piece.new, Piece.new, Piece.new, Piece.new]
  START_BOARD_3 = Array.new(8, NullPiece.instance)
  START_BOARD_4 = Array.new(8, NullPiece.instance)
  START_BOARD_5 = Array.new(8, NullPiece.instance)
  START_BOARD_6 = Array.new(8, NullPiece.instance)
  START_BOARD_7 = [Piece.new, Piece.new, Piece.new, Piece.new, Piece.new, Piece.new, Piece.new, Piece.new]
  START_BOARD_8 = [Piece.new, Piece.new, Piece.new, Piece.new, Piece.new, Piece.new, Piece.new, Piece.new]
  START_BOARD = [START_BOARD_1, START_BOARD_2, START_BOARD_3, START_BOARD_4, START_BOARD_5, START_BOARD_6, START_BOARD_7, START_BOARD_8]

  def initialize(grid = START_BOARD)
    @grid = grid
  end

  def [](pos)
    x, y = pos
    @grid[x][y]
  end

  def []=(pos, value)
    x, y = pos
    @grid[x][y] = value
  end

  def move(start, end_pos)
    if self[start].is_a? NullPiece
      raise ArgumentError.new "No piece there"
    elsif !self[start].moves.include?(end_pos)
      raise ArgumentError.new "Can't move there"
    else
      self[end_pos] = self[start]
      self[start] = NullPiece.instance
    end
  end


end
