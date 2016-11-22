require_relative 'display'

class Game

  def initialize
    @board = Board.setup
    @cursor = Cursor.new([0, 0], @board)
    @display = Display.new(@board, @cursor)
    @move = []
  end

  def play
    loop do
      system('clear')
      @display.render
      begin
        get_move
        if @move.length == 2
          @board.move_piece(@move.first, @move.last)
          if @board.checkmate?(:red)
            p "Game Over"
            return true
          end
          @move = []
        end
      rescue StandardError => e
        puts e
        @move = []
        sleep(1)
      end

    end
  end

  def get_move
    pos = @cursor.get_input
    unless pos.nil?
      if @board[pos] == NullPiece.instance && @move.empty?
        raise "No piece at starting position."
      end
      @move << pos
    end
  end

end

Game.new.play
