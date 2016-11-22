require 'byebug'

module ValidMove
  def valid_move?(pos)
    # needs logic for taking enemy piece
    empty_space?(pos) && in_bounds?(pos)
  end

  def in_bounds?(pos)
    pos.all? { |idx| (0..7).cover?(idx) }
  end

  def empty_space?(pos)
    @board[pos] == NullPiece.instance
  end
end

module SlidingPiece
  include ValidMove

  def moves
    case self.class.to_s
    when "Bishop" then diagonal_moves
    when "Rook"   then straight_moves
    when "Queen"  then diagonal_moves + straight_moves
    end
  end

  private

  STRAIGHT_DELTA = [[-1, 0], [0, 1], [1, 0], [0, -1]].freeze
  DIAGONAL_DELTA = [[-1, -1], [-1, 1], [1, 1], [1, -1]].freeze

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
      while valid_move?(pos)
        poss_moves << pos
        pos = [pos.first + delta_row, pos.last + delta_col]
      end
    end
    poss_moves
  end
end

module SteppingPiece
  include ValidMove

  def moves
    deltas = self.class == King ? KING_DELTAS : KNIGHT_DELTAS
    row, col = @position
    poss_moves = deltas.map do |row_delta, col_delta|
      [row + row_delta, col + col_delta]
    end

    remove_invalid_moves(poss_moves)
  end

  private

  KNIGHT_DELTAS = [[-2, -1],
                   [-2, 1],
                   [-1, 2],
                   [1, 2],
                   [2, 1],
                   [2, -1],
                   [1, -2],
                   [-1, -2]].freeze

  KING_DELTAS = [[-1,-1], [-1, 0], [-1,  1], [0, -1],
                 [ 0, 1], [ 1, 0], [ 1, -1], [1,  1]].freeze

  def remove_invalid_moves(array)
    array.select do |move|
      valid_move?(move)
    end
  end


end
