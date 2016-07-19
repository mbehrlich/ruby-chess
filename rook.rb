require_relative 'piece'
require_relative 'sliding_piece'
class Rook < Piece

  include SlidingPiece

  def to_s
    piece_symbol = " \u265C  "
    piece_symbol.encode('utf-8')
  end

end
