require_relative 'move_module'
require 'singleton'

class Piece
  attr_reader :color
  attr_accessor :position, :board

  def initialize(position, board, color)
    @position = position
    @board = board
    @color = color
  end

end

class NullPiece < Piece
  include Singleton

  def initialize
    @color = :brown
  end

  def moves
    []
  end

  def to_s
    '  '
  end
end

class Pawn < Piece
  include ValidMove
  def initialize(position, board, color)
    super
    @starting_position = position
  end

  def moves
    poss_moves = []

    direction = @starting_position.first == 1 ? 1 : -1

    pos = [@position.first + direction, @position.last]

    poss_moves << pos if empty_space?(pos)

    if @starting_position == @position && valid_move?(pos)
      two_space_move = [pos.first + direction, pos.last]
      poss_moves << two_space_move if empty_space?(two_space_move)
    end

    poss_moves + diagonal_moves(pos)
  end

  def diagonal_moves(pos)
    dia_moves = []
    [-1, 1].each do |col_delta|
      dia_pos = [pos.first, pos.last + col_delta]
      dia_moves << dia_pos if in_bounds?(dia_pos) && is_enemy?(dia_pos)
    end
    dia_moves
  end

  def to_s
    self.color == :white ? "\u2659" : "\u265F"
  end

end

class Bishop < Piece
  include SlidingPiece
  def to_s
    self.color == :white ? "\u2657" : "\u265D"
  end
end

class Rook < Piece
  include SlidingPiece
  def to_s
    self.color == :white ? "\u2656" : "\u265C"
  end
end

class Queen < Piece
  include SlidingPiece
  def to_s
    self.color == :white ? "\u2655" : "\u265B"
  end
end

class Knight < Piece
  include SteppingPiece
  def to_s
    self.color == :white ? "\u2658" : "\u265E"
  end
end

class King < Piece
  include SteppingPiece
  def to_s
    self.color == :white ? "\u2654" : "\u265A"
  end
end

# For fun
# dynamic_name = "ClassName"
# Object.const_set(dynamic_name, Class.new { def method1() 42 end })
# ClassName.new.method1 #=> 42
# Dijkstra's algorithm
