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
    moves.reject { |move| move_into_check?(move) }
  end

  def move_into_check?(end_pos)
    test_board = @board.dup
    test_board.move(@pos, end_pos)
    return test_board.in_check?(@color)
  end

end
