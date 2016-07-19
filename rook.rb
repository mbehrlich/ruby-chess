require_relative 'piece'
require_relative 'sliding_piece'
class Rook < Piece

  include SlidingPiece

  attr_reader :moves_num


  def to_s
    piece_symbol = " \u265C  "
    piece_symbol.encode('utf-8')
  end

end
