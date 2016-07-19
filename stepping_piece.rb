module SteppingPiece

  def moves
    move_list = []
    iterator = @pos
    knight_deltas = [[2,1], [1, 2], [-1, 2], [-2, 1],[-2,-1],[-1,-2],[1,-2],[2,-1]]
    king_deltas = [[1,1], [-1, -1], [1, -1], [-1, 1],[0,1], [0, -1], [1, 0], [-1, 0]]
    deltas = []
    deltas += knight_deltas unless self.is_a? King
    deltas += king_deltas unless self.is_a? Knight
    deltas.each do |mover|
      unless @board[iterator] != NullPiece.instance && iterator != @pos
        iterator = [iterator[0] + mover[0], iterator[1] + mover[1]]
        if @board.in_bounds?(iterator)
          move_list << iterator if @board[iterator].color != @color
        end
      end
      iterator = @pos
    end
    if self.class == King
      @color == :black ? row = 0 : row = 7
      king_not_moved = (self.moves_num == 0)
      qrook = (@board[[row, 0]].class == Rook) && (@board[[row,0]].moves_num == 0)
      krook = (@board[[row, 7]].class == Rook) && (@board[[row,7]].moves_num == 0)
      left_empty = @board[[row,1]] == NullPiece.instance && @board[[row,2]] == NullPiece.instance && @board[[row,3]] == NullPiece.instance
      right_empty = @board[[row,5]] == NullPiece.instance && @board[[row,6]] == NullPiece.instance
      if king_not_moved && qrook && left_empty
        move_list << [row, 2]
      end
      if king_not_moved && krook && right_empty
        move_list << [row, 6]
      end
    end
    move_list
  end



end
