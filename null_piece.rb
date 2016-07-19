require 'singleton'

class NullPiece
  include Singleton

  def load_board(board, pos)
  end

  def to_s
    "    "
  end

  def color
    :yellow
  end

  def moves
    []
  end
end
