require_relative 'piece'

class Pawn < Piece

  def to_s
    piece_symbol = " \u2659  "
    piece_symbol.encode('utf-8')
  end

end
