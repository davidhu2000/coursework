require_relative 'cursor'

class HumanPlayer
  attr_reader :name, :color

  def initialize(name, color, display)
    @name = name
    @color = color
    @display = display
    @cursor = display.cursor
    @board = display.board
  end

  def play_turn
    move = []
    until move.length == 2
      @display.render
      pos = @cursor.get_input
      next unless pos

      if @board[pos] == NullPiece.instance && move.empty?
        raise 'No piece at starting position.'
      end
      move << pos
      if move.length == 1
        @display.selected = pos
      end
    end
    @display.selected = []
    move
  end
end
