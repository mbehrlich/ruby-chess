require_relative 'piece'
require_relative 'sliding_piece'

class Queen < Piece

  include SlidingPiece

  def to_s
    piece_symbol = " \u265B  "
    piece_symbol.encode('utf-8')
  end


end
