require_relative 'piece'
require_relative 'sliding_piece'
class Rook < Piece

  include SlidingPiece

  def to_s
    piece_symbol = " \u2656  "
    piece_symbol.encode('utf-8')
  end

end
