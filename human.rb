require_relative 'cursor'

class HumanPlayer
  attr_reader :name, :color

  def initialize(name, color, display)
    @name = name
    @color = color
    @display = display
    @cursor = display.cursor
    @board = display.board
    @move = []
  end

  def play_turn
    until @move.length == 2
      @display.render
      pos = @cursor.get_input
      unless pos.nil?
        if @board[pos] == NullPiece.instance && @move.empty?
          raise 'No piece at starting position.'
        end
        @move << pos
      end
    end
    return_move = @move
    @move = []
    return_move
  end
end
