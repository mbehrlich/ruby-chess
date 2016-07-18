require_relative 'piece'
require_relative 'sliding_piece'

class Bishop < Piece

  include SlidingPiece

  def to_s
    piece_symbol = " \u2657  "
    piece_symbol.encode('utf-8')
  end
end
