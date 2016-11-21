require_relative 'board'

class Piece
  def initialize(position, board)
    @position = position
    @board = board
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

  def initialize(position, board)
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

  def initialize(position, board)
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

board = Board.new
knight = Knight.new([0, 1], board)
p knight.moves
