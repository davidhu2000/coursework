require_relative "piece"
require 'byebug'

class Board


  STARTING_POSITIONS = {
    rook: [[0,0], [0,7], [7,0], [7,7]],
    knight: [[0,1], [0,6], [7,1], [7,6]],
    bishop: [[0,2], [0,5], [7,2], [7,5]],
    king: [[0,4], [7,4]],
    queen: [[0,3], [7,3]]
  }.freeze

  def self.setup

    board = Board.empty_board

    # set non-pawn pieces
    STARTING_POSITIONS.each do |piece, positions|
      positions.each do |pos|
        color = pos.first == 0 ? :red : :white
        board[pos] = Kernel.const_get(piece.to_s.capitalize).new(pos, board, color)
      end
    end

    # set pawns + null piece
    (0..7).each do |col|
      board.grid[1][col] = Pawn.new([1, col], board, :red)
      board.grid[6][col] = Pawn.new([6, col], board, :white)

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
    piece = self[start_pos]

    raise "Invalid move" unless piece.moves.include?(end_pos)

    if piece.into_check?(end_pos)
      if in_check?(piece.color)
        raise "Must move out of check"
      end
      raise "Cannot move into check"
    end
    self[end_pos] = piece
    piece.position = end_pos
    self[start_pos] = NullPiece.instance
  end

  def shift_position(start_pos, end_pos)
    piece = self[start_pos]
    self[end_pos] = piece
    piece.position = end_pos
    self[start_pos] = NullPiece.instance
  end

  def in_bounds?(pos)
    pos.all? { |idx| (0..7).cover?(idx) }
  end

  def in_check?(color)
    king_pos = king_position(color)

    grid.each do |row|
      row.each do |piece|
        unless piece.is_a?(NullPiece) || piece.color == color
          return true if piece.moves.include?(king_pos)
        end
      end
    end
    false
  end

  def checkmate?(color)
    return false unless in_check?(color)

    grid.each do |row|
      row.each do |piece|
        next unless piece.color == color

        return false if move_out_of_check?(piece)
      end
    end
    true
  end

  def move_out_of_check?(piece)
    piece.moves.each do |move|
      start_pos = piece.position
      prev_piece = self[move]
      shift_position(start_pos, move)

      in_check = in_check?(piece.color)
      shift_position(move, start_pos)
      self[move] = prev_piece
      return true unless in_check
    end
    nil
  end

  def king_position(color)
    grid.each_with_index do |row, row_index|
      col_index = row.find_index do |piece|
        piece.is_a?(King) && piece.color == color
      end
      return [row_index, col_index] if col_index
    end
  end
end
