require_relative "piece"

class Board

  STARTING_POSITIONS = {
    rook: [[0,0], [0,7], [7,0], [7,7]],
    knight: [[0,1], [0,6], [7,1], [7,6]],
    bishop: [[0,2], [0,5], [7,2], [7,5]],
    king: [[0,3], [7,3]],
    queen: [[0,4], [7,4]]
  }.freeze

  def self.setup

    board = Board.empty_board

    # set non-pawn pieces
    STARTING_POSITIONS.each do |piece, positions|
      positions.each do |pos|
        board[pos] = Kernel.const_get(piece.to_s.capitalize).new(pos, board, :black)
      end
    end

    # set pawns + null piece
    (0..7).each do |col|
      board.grid[1][col] = :pawn
      board.grid[6][col] = :pawn

      (2..5).each do |row|
        board.grid[row][col] = NullPiece.instance
      end

    end

    board
  end

  def self.empty_board
    grid = Array.new(8) { Array.new(8) }
    self.new(grid)
  end

  attr_accessor :grid

  def initialize(grid)
    @grid = grid
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []=(pos, value)
    row, col = pos
    @grid[row][col] = value
  end

  def move_piece(start_pos, end_pos)
    raise "No piece at starting position." if self[start_pos] == "Null"
    # raise exception if piece cannot move to end_pos
    piece = self[start_pos]
    self[end_pos] = piece
    self[start_pos] = "Null"
  end

  def in_bounds?(pos)
    pos.all? { |idx| (0..7).cover?(idx) }
  end
end
