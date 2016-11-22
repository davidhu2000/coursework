require_relative 'board'
require_relative 'move_module'

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
