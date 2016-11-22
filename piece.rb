require_relative 'board'

class Piece
  def initialize(position, board, color)
    @position = position
    @board = board
    @color = color
  end

  def moves
  end

  # do not call on instances of Piece.
  def remove_invalid_moves(array)
    array.select do |move|
      @board.in_bounds?(move) && valid_move?(move)
    end
  end
end

module SlidingPiece
  STRAIGHT_DELTA = [[-1, 0], [0, 1], [1, 0], [0, -1]].freeze
  DIAGONAL_DELTA = [[-1, -1], [-1, 1], [1, 1], [1, -1]].freeze

  def valid_move?(end_pos)
    # delta_row = end_pos.first - @position.first
    # delta_col = end_pos.last - @position.last
    # delta_row /= delta_row.abs unless delta_row.zero?
    # delta_col /= delta_col.abs unless delta_col.zero?
    # pos = @position.dup
    # until pos == end_pos
    #   pos = [pos.first + delta_row, pos.last + delta_col]
    #   return false unless board[pos] == "Null"
    # end
    # true

    # needs logic for taking enemy piece
    @board[end_pos] == 'Null'

  end

  def moves
    case self.class.to_s
    when "Bishop" then diagonal_moves
    when "Rook"   then straight_moves
    when "Queen"  then diagonal_moves + straight_moves
    end
  end

  def diagonal_moves
    get_moves(DIAGONAL_DELTA)
  end

  def straight_moves
    get_moves(STRAIGHT_DELTA)
  end

  def get_moves(deltas)
    poss_moves = []
    deltas.each do |delta_row, delta_col|
      pos = @position.dup
      pos = [pos.first + delta_row, pos.last + delta_col]
      while @board.in_bounds?(pos) && valid_move?(pos)
        poss_moves << pos
        pos = [pos.first + delta_row, pos.last + delta_col]
      end
    end
    poss_moves
  end
end

class Bishop < Piece
  include SlidingPiece

  def initialize(position, board, color)
    super
  end
end

class Rook < Piece
  include SlidingPiece

  def initialize(position, board, color)
    super
  end
end

class Queen < Piece
  include SlidingPiece

  def initialize(position, board, color)
    super
  end
end

module SteppingPiece
  def valid_move?(end_pos)
    # needs logic for taking enemy piece
    @board[end_pos] == 'Null'
  end
end

class Knight < Piece
  include SteppingPiece

  DELTAS = [[-2, -1],
            [-2, 1],
            [-1, 2],
            [1, 2],
            [2, 1],
            [2, -1],
            [1, -2],
            [-1, -2]].freeze

  def initialize(position, board, color)
    super
  end

  def moves
    row, col = @position
    poss_moves = DELTAS.map do |row_delta, col_delta|
      [row + row_delta, col + col_delta]
    end

    remove_invalid_moves(poss_moves)
  end
end

class King < Piece
  include SteppingPiece

  def initialize(position, board, color)
    super
  end

  def moves
    row, col = @position

    poss_moves = []
    (-1..1).each do |row_delta|
      (-1..1).each do |col_delta|
        next if row_delta.zero? && col_delta.zero?
        poss_moves << [row + row_delta, col + col_delta]
      end
    end

    remove_invalid_moves(poss_moves)
  end

end

# # board = Board.new
# # knight = Knight.new([0, 1], board, :black)
# # p knight.moves
# board = Board.new
# board[[1,4]] = 'Null'
# board[[1,2]] = 'Null'
# board[[1,3]] = 'Null'
# # board[[3,5]] = :knight
# # bis = Bishop.new([0,2], board, :black)
# # p bis.moves
# # rook = Rook.new([0,0], board, :black)
# # p rook.moves
# q = Queen.new([0,3], board, :black)
# p q.moves
