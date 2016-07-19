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

end
