require_relative 'piece'
require_relative 'stepping_piece'
class King < Piece


    include SteppingPiece
  def to_s
    piece_symbol = " \u265A  "
    piece_symbol.encode('utf-8')
  end


end
