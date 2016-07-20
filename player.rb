require_relative 'errors'

class Player

  attr_reader :name

  def initialize(name)
    @name = name
  end

  def load_info(color, display, board)
    @color = color
    @display = display
    @board = board
  end

end

class ComputerPlayer < Player
  def play_turn
    move_hash = {}
    @board.grid.each do |row|
      row.each do |piece|
        if piece.color == @color
          move_hash[piece.pos] = piece.valid_moves unless piece.valid_moves.length == 0
        end
      end
    end
    random1 = rand(move_hash.keys.length)
    random_starter = move_hash.keys[random1]
    random2 = rand(move_hash[random_starter].length)
    random_end = move_hash[random_starter][random2]
    system "clear"
    @display.render
    [random_starter,random_end]
  end

  def promotion(pos)
    @board[pos] = Queen.new(@board[pos].color)
    @board[pos].load_board(@board, pos)
  end


end



class HumanPlayer < Player

  def play_turn
    begin
      message1 = "#{@name}, it's your turn"
      message2 = "Select a piece"
      start_pos = @display.cursor_move(message1, message2)
      raise WrongColor.new if @board[start_pos].color != @color
      p start_pos
      message1 = "Make a valid move with #{@board[start_pos].class}"
      message2 = ''
      end_pos = @display.cursor_move(message1, message2)
      raise SamePiece.new if start_pos == end_pos
      raise InvalidMove.new unless @board[start_pos].valid_moves.include?(end_pos)
    rescue => error
      if error.class == InvalidMove
        message2 = "Invalid move"
        end_pos = @display.cursor_move(message1, message2)
        retry unless @board[start_pos].valid_moves.include?(end_pos)
      elsif error.class == WrongColor || error.class == SamePiece
        retry
      end
    end
    [start_pos, end_pos]
  end

  def promotion(pos)
    puts "What would you like to promote your pawn to?"
    puts "(Press Q for queen, R for Rook, K for Knight, or B for Bishop)"
    new_piece = gets.chomp.downcase
    until new_piece == 'q' || new_piece == 'r' || new_piece == 'k' || new_piece == 'b'
      new_piece = gets.chomp.downcase
    end
    case new_piece
    when 'q'
      @board[pos] = Queen.new(@board[pos].color)
    when 'r'
      @board[pos] = Rook.new(@board[pos].color)
    when 'k'
      @board[pos] = Knight.new(@board[pos].color)
    when 'b'
      @board[pos] = Bishop.new(@board[pos].color)
    end
    @board[pos].load_board(@board, pos)
  end

end
