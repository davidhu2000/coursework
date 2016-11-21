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
  def valid_move?(end_pos)
    delta_row = end_pos.first - @position.first
    delta_col = end_pos.last - @position.last
    delta_row /= delta_row.abs unless delta_row.zero?
    delta_col /= delta_col.abs unless delta_col.zero?
    pos = @position.dup
    until pos == end_pos
      pos = [pos.first + delta_row, pos.last + delta_col]
      return false unless board[pos] == "Null"
    end
    true
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

board = Board.new
knight = Knight.new([0, 1], board)
p knight.moves
