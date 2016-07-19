require_relative 'piece'
require_relative 'stepping_piece'

class Knight < Piece

  include SteppingPiece

  def to_s
    piece_symbol = " \u2658  "
    piece_symbol.encode('utf-8')
  end

end
