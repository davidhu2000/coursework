require_relative 'board'
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

  def initialize(position, board, color)
    super
  end
end

class King < Piece
  include SteppingPiece

  def initialize(position, board, color)
    super
  end

end



# board = Board.new
# # board[[1,3]] = 'Null'
# # king = King.new([0, 4], board, :black)
# # p king.moves
# # knight = Knight.new([0, 1], board, :black)
# # p knight.moves
#
# # board = Board.new
# # board[[1,4]] = 'Null'
# # board[[1,2]] = 'Null'
# board[[1, 1]] = 'Null'
# board[[1, 3]] = 'Null'
# # board[[3,5]] = :knight
# bis = Bishop.new([0, 2], board, :black)
# p bis.moves
# # # rook = Rook.new([0,0], board, :black)
# # # p rook.moves
# # q = Queen.new([0,3], board, :black)
# # p q.moves
