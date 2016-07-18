require_relative 'piece'

class Knight < Piece
  def to_s
    piece_symbol = " \u2658  "
    piece_symbol.encode('utf-8')
  end

end
