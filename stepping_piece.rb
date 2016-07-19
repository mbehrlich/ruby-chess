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
    move_list
  end



end
