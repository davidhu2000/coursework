module SlidingPiece
  STRAIGHT_DELTA = [[-1, 0], [0, 1], [1, 0], [0, -1]].freeze
  DIAGONAL_DELTA = [[-1, -1], [-1, 1], [1, 1], [1, -1]].freeze

  def valid_move?(end_pos)
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

module SteppingPiece
  def valid_move?(end_pos)
    # needs logic for taking enemy piece
    @board[end_pos] == 'Null'
  end

  def remove_invalid_moves(array)
    array.select do |move|
      @board.in_bounds?(move) && valid_move?(move)
    end
  end
end
