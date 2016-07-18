require_relative 'piece'
class King < Piece

  def to_s
    piece_symbol = " \u2654  "
    piece_symbol.encode('utf-8')
  end


end
