require_relative 'piece'
require_relative 'null_piece'
require_relative 'rook'
require_relative 'knight'
require_relative 'bishop'
require_relative 'king'
require_relative 'queen'
require_relative 'pawn'



class Board
  START_BOARD_1 = [Rook.new(:black), Knight.new(:black), Bishop.new(:black), Queen.new(:black), King.new(:black), Bishop.new(:black), Knight.new(:black), Rook.new(:black)]
  START_BOARD_2 = [Pawn.new(:black), Pawn.new(:black), Pawn.new(:black), Pawn.new(:black), Pawn.new(:black), Pawn.new(:black), Pawn.new(:black), Pawn.new(:black)]
  START_BOARD_3 = Array.new(8, NullPiece.instance)
  START_BOARD_4 = Array.new(8, NullPiece.instance)
  START_BOARD_5 = Array.new(8, NullPiece.instance)
  START_BOARD_6 = Array.new(8, NullPiece.instance)
  START_BOARD_7 = [Pawn.new(:light_white), Pawn.new(:light_white), Pawn.new(:light_white), Pawn.new(:light_white), Pawn.new(:light_white), Pawn.new(:light_white), Pawn.new(:light_white), Pawn.new(:light_white)]
  START_BOARD_8 = [Rook.new(:light_white), Knight.new(:light_white), Bishop.new(:light_white), King.new(:light_white), Queen.new(:light_white), Bishop.new(:light_white), Knight.new(:light_white), Rook.new(:light_white)]
  START_BOARD = [START_BOARD_1, START_BOARD_2, START_BOARD_3, START_BOARD_4, START_BOARD_5, START_BOARD_6, START_BOARD_7, START_BOARD_8]

  attr_reader :grid

  def initialize(grid = START_BOARD)
    @grid = grid
    load_board
  end

  def [](pos)
    x, y = pos
    @grid[x][y]
  end

  def []=(pos, value)
    x, y = pos
    @grid[x][y] = value
  end

  def load_board
    @grid.each_with_index do |row, row_idx|
      row.each_with_index do |piece, col_idx|
        pos = [row_idx, col_idx]
        piece.load_board(self, pos)
      end
    end
  end

  def move(start, end_pos)
    if self[start].is_a? NullPiece
      raise ArgumentError.new "No piece there"
    elsif !self[start].moves.include?(end_pos)
      raise ArgumentError.new "Can't move there"
    else
      self[end_pos] = self[start]
      self[end_pos].pos = end_pos
      self[start] = NullPiece.instance
    end
  end

  def in_bounds?(pos)
    x, y = pos
    return false if x < 0 || x > @grid.length - 1 || y < 0 || y > @grid.length - 1
    true
  end


end
