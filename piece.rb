class Piece

  attr_reader :color
  attr_accessor :pos

  def initialize(color)
    @color = color
  end

  def load_board(board, pos)
    @board = board
    @pos = pos
  end

  def valid_moves

  end

  def move_into_check?(pos)

  end

end
