require_relative 'piece'
require 'byebug'
class Pawn < Piece

  def initialize(color)
    @moves = 0
    super
  end

  def moves
    move_list = []
    iterator = @pos
    if @color == :black
      deltas = [[1, 0]]
      deltas << [2, 0] if @moves == 0
    else
      deltas = [[-1, 0]]
      deltas << [-2, 0] if @moves == 0
    end
    deltas.each do |mover|
      if @board[[iterator[0] + deltas[0][0], iterator[1] + deltas[0][1]]] == NullPiece.instance
        iterator = [iterator[0] + mover[0], iterator[1] + mover[1]]
        if @board.in_bounds?(iterator)
          move_list << iterator if @board[iterator].color == :yellow
        end
      end
      iterator = @pos
    end
    if @color == :black
      enemy_check1 = [iterator[0] + 1, iterator[1] + 1]
      enemy_check2 = [iterator[0] + 1, iterator[1] - 1]
    else
      enemy_check1 = [iterator[0] - 1, iterator[1] + 1]
      enemy_check2 = [iterator[0] - 1, iterator[1] - 1]
    end
    move_list << enemy_check1 unless @board[enemy_check1] == NullPiece.instance || @board[enemy_check1].color == @color
    move_list << enemy_check2 unless @board[enemy_check2] == NullPiece.instance || @board[enemy_check2].color == @color
    move_list
  end




  def to_s
    piece_symbol = " \u2659  "
    piece_symbol.encode('utf-8')
  end

end
