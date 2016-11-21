

class Board

  STARTING_POSITIONS = {
    rook: [[0,0], [0,7], [7,0], [7,7]],
    knight: [[0,1], [0,6], [7,1], [7,6]],
    bishop: [[0,2], [0,5], [7,2], [7,5]],
    king: [[0,3], [7,3]],
    queen: [[0,4], [7,4]]
  }.freeze

  def self.setup


    grid = Array.new(8) { Array.new(8) }

    # set non-pawn pieces
    STARTING_POSITIONS.each do |piece, positions|
      positions.each do |pos|
        row, col = pos
        grid[row][col] = piece
      end
    end

    # set pawns + null piece
    (0..7).each do |col|
      grid[1][col] = :pawn
      grid[6][col] = :pawn

      (2..5).each do |row|
        grid[row][col] = 'Null'
      end

    end

    grid
  end

  attr_accessor :grid

  def initialize
    @grid = Board.setup
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
end

board  = Board.new
p board.grid
