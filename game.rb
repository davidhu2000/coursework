require_relative 'display'
require_relative 'human'

class Game

  def initialize
    @board = Board.setup
    @cursor = Cursor.new([0, 0], @board)
    @display = Display.new(@board, @cursor)
    @move = []
    @player1 = HumanPlayer.new(:white, "Human1")
    @player2 = HumanPlayer.new(:red, "Human2")
    @current_player = @player1
  end

  def play
    until @board.checkmate?(@player1.color) || @board.checkmate?(@player2.color)
      system('clear')
      @display.render
      begin

        move = @current_player.play_turn

        if @move.length == 2
          @board.move_piece(@move.first, @move.last)
          @move = []
        end
      rescue StandardError => e
        puts e
        @move = []
        sleep(1)
      end
    end

    puts 'Game Over!'
    puts "Winner is #{@current_player.name}"
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
