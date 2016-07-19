require_relative 'piece'
require 'byebug'
class Pawn < Piece

  attr_reader :moves_num

  def initialize(color, moves_num = 0)
    @color = color
    @moves_num = moves_num
    @double_move = false
  end

  def record_double_move
    @double_move = true
  end

  def un_double
    @double_move = false
  end

  def check_double_move?
    @double_move
  end

  def moves
    move_list = []
    iterator = @pos
    if @color == :black
      deltas = [[1, 0]]
      deltas << [2, 0] if @moves_num == 0
    else
      deltas = [[-1, 0]]
      deltas << [-2, 0] if @moves_num == 0
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
    en_passant1 = [iterator[0], iterator[1] + 1]
    en_passant2 = [iterator[0], iterator[1] - 1]
    move_list << enemy_check1 unless @board[enemy_check1].nil? || @board[enemy_check1] == NullPiece.instance || @board[enemy_check1].color == @color
    move_list << enemy_check2 unless @board[enemy_check1].nil? || @board[enemy_check2] == NullPiece.instance || @board[enemy_check2].color == @color
    move_list << enemy_check1 if @board[en_passant1].class == Pawn && @board[en_passant1].check_double_move?
    move_list << enemy_check2 if @board[en_passant2].class == Pawn && @board[en_passant2].check_double_move?
    move_list
  end




  def to_s
    piece_symbol = " \u265F  "
    piece_symbol.encode('utf-8')
  end

end
