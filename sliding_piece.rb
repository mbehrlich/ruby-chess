module SlidingPiece

  # def moves
  #   move_list = []
  #   move_list += flat_moves unless self.is_a? Bishop
  #   move_list += diagonal_moves unless self.is_a? Rook
  #   move_list
  # end

  def moves
    move_list = []
    iterator = @pos
    flat_deltas = [[0,1], [0, -1], [1, 0], [-1, 0]]
    diagonal_deltas = [[1,1], [-1, -1], [1, -1], [-1, 1]]
    deltas = []
    deltas += flat_deltas unless self.is_a? Bishop
    deltas += diagonal_deltas unless self.is_a? Rook
    deltas.each do |mover|
      until @board[iterator] != NullPiece.instance && iterator != @pos
        iterator = [iterator[0] + mover[0], iterator[1] + mover[1]]
        break unless @board.in_bounds?(iterator)
        move_list << iterator if @board[iterator].color != @color
      end
      iterator = @pos
    end
    move_list
  end

  # def diagonal_moves
  #   move_list = []
  #   iterator = @pos
  #   deltas = [[1,1], [-1, -1], [1, -1], [-1, 1]]
  #   deltas.each do |mover|
  #     until @board[iterator] != NullPiece.instance && iterator != @pos
  #       iterator = [iterator[0] + mover[0], iterator[1] + mover[1]]
  #       break unless @board.in_bounds?(iterator)
  #       move_list << iterator if @board[iterator].color != @color
  #     end
  #     iterator = @pos
  #   end
  #   move_list
  # end

end
