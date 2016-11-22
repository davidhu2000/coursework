# require_relative 'board'
require_relative 'move_module'
require 'singleton'

class Piece
  def initialize(position, board, color)
    @position = position
    @board = board
    @color = color
  end

  def to_s
    self.class.to_s.slice(0, 2)
  end
end

class NullPiece < Piece
  include Singleton
  attr_reader :color, :symbol

  def initialize
    @color = :brown
    @symbol = :null
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
    poss_moves << pos if valid_move?(pos)

    if @starting_position == @position && valid_move?(pos)
      two_space_move = [pos.first + direction, pos.last]
      poss_moves << two_space_move if valid_move?(two_space_move)
    end

    [-1, 1].each do |col_delta|
      dia_pos = [pos.first, pos.last + col_delta]
      poss_moves << dia_pos unless empty_space?(dia_pos)
      # add check to see if diagonbal has enemy pieces.
    end
    poss_moves
  end


end

class Bishop < Piece
  include SlidingPiece
end

class Rook < Piece
  include SlidingPiece
end

class Queen < Piece
  include SlidingPiece
end

class Knight < Piece
  include SteppingPiece
end

class King < Piece
  include SteppingPiece
end

# For fun
# dynamic_name = "ClassName"
# Object.const_set(dynamic_name, Class.new { def method1() 42 end })
# ClassName.new.method1 #=> 42
