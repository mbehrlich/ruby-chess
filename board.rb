require_relative 'piece'
require_relative 'null_piece'
require_relative 'rook'
require_relative 'knight'
require_relative 'bishop'
require_relative 'king'
require_relative 'queen'
require_relative 'pawn'



class Board
  START_BOARD_1 = [Rook.new(:black), Knight.new(:black), Bishop.new(:black), Queen.new(:black), King.new(:black), Bishop.new(:black), Knight.new(:black), Rook.new(:black)]
  START_BOARD_2 = [Pawn.new(:black), Pawn.new(:black), Pawn.new(:black), Pawn.new(:black), Pawn.new(:black), Pawn.new(:black), Pawn.new(:black), Pawn.new(:black)]
  START_BOARD_3 = Array.new(8, NullPiece.instance)
  START_BOARD_4 = Array.new(8, NullPiece.instance)
  START_BOARD_5 = Array.new(8, NullPiece.instance)
  START_BOARD_6 = Array.new(8, NullPiece.instance)
  START_BOARD_7 = [Pawn.new(:light_white), Pawn.new(:light_white), Pawn.new(:light_white), Pawn.new(:light_white), Pawn.new(:light_white), Pawn.new(:light_white), Pawn.new(:light_white), Pawn.new(:light_white)]
  START_BOARD_8 = [Rook.new(:light_white), Knight.new(:light_white), Bishop.new(:light_white), Queen.new(:light_white), King.new(:light_white), Bishop.new(:light_white), Knight.new(:light_white), Rook.new(:light_white)]
  START_BOARD = [START_BOARD_1, START_BOARD_2, START_BOARD_3, START_BOARD_4, START_BOARD_5, START_BOARD_6, START_BOARD_7, START_BOARD_8]

  attr_reader :grid

  def initialize(grid = START_BOARD, dup = false)
    @grid = grid
    @dup = dup
    load_board
    @last_piece_moved = nil
  end

  def [](pos)
    x, y = pos
    @grid[x][y]
  end

  def []=(pos, value)
    x, y = pos
    @grid[x][y] = value
  end

  def load_board
    @grid.each_with_index do |row, row_idx|
      row.each_with_index do |piece, col_idx|
        pos = [row_idx, col_idx]
        piece.load_board(self, pos)
      end
    end
  end

  def move(start, end_pos)
    self[end_pos] = self[start]
    self[end_pos].pos = end_pos
    self[start] = NullPiece.instance
    self[end_pos].moves_num += 1
    # Castling logic
    if self[end_pos].class == King && start[1] - end_pos[1] == 2
      self[[end_pos[0], 3]] = self[[end_pos[0], 0]]
      self[[end_pos[0], 3]].pos = [end_pos[0], 3]
      self[[end_pos[0], 0]] = NullPiece.instance
    elsif self[end_pos].class == King && start[1] - end_pos[1] == -2
      self[[end_pos[0], 5]] = self[[end_pos[0], 7]]
      self[[end_pos[0], 5]].pos = [end_pos[0], 5]
      self[[end_pos[0], 7]] = NullPiece.instance
    end
    # En Passant Logic
    if self[end_pos].class == Pawn && (start[0] - end_pos[0] == 2 || start[0] - end_pos[0] == -2)
      self[end_pos].record_double_move
    end
    passant_checker = @color == :black ? -1 : 1
    passanted = [end_pos[0] + passant_checker, end_pos[1]]
    if self[end_pos].class == Pawn && self[passanted].class == Pawn && self[passanted].check_double_move?
      self[passanted] = NullPiece.instance
    end
    # Promotion Logic
    if self[end_pos].class == Pawn && (end_pos[0] == 0 || end_pos[0] == 7)
      if @dup
        self[end_pos] = Queen.new(self[end_pos].color)
      else
        promotion(end_pos)
      end
    end
    @last_piece_moved.un_double if @last_piece_moved.class == Pawn
    @last_piece_moved = self[end_pos]
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
      self[pos] = Queen.new(self[pos].color)
    when 'r'
      self[pos] = Rook.new(self[pos].color)
    when 'k'
      self[pos] = Knight.new(self[pos].color)
    when 'b'
      self[pos] = Bishop.new(self[pos].color)
    end
    self[pos].load_board(self, pos)
  end

  def in_bounds?(pos)
    x, y = pos
    return false if x < 0 || x > @grid.length - 1 || y < 0 || y > @grid.length - 1
    true
  end

  def in_check?(color)
    possible_moves = []
    king_pos = nil
    @grid.each_with_index do |row, row_idx|
      row.each_with_index do |piece, col_idx|
        king_pos = [row_idx, col_idx] if piece.class == King && piece.color == color
        possible_moves += self[[row_idx, col_idx]].moves if piece.color != color
      end
    end
    possible_moves.include?(king_pos)
  end

  def checkmate?(color)
    valid_moves = false
    @grid.each_with_index do |row, row_idx|
      row.each_with_index do |piece, col_idx|
        valid_moves = true unless piece.color != color || piece.valid_moves.empty?
      end
    end
    in_check?(color) && !valid_moves
  end

  def stalemate?(color)
    valid_moves = false
    @grid.each_with_index do |row, row_idx|
      row.each_with_index do |piece, col_idx|
        valid_moves = true unless piece.color != color || piece.valid_moves.empty?
      end
    end
    !in_check?(color) && !valid_moves
  end

  def dup
    new_grid = []
    @grid.each_with_index do |row, row_idx|
      new_grid << []
      row.each_with_index do |piece, col_idx|
        pos = [row_idx, col_idx]
        if self[pos] == NullPiece.instance
          new_grid[row_idx] << NullPiece.instance
        else
          piece_class = piece.class
          color = piece.color
          if piece_class == Pawn
            moves_num = piece.moves_num
            new_grid[row_idx] << piece_class.new(color, moves_num)
          else
            new_grid[row_idx] << piece_class.new(color)
          end
        end
      end
    end
    Board.new(new_grid, true)
  end

end
