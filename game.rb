require_relative 'display'
require_relative 'human'

class Game

  def initialize
    @board = Board.setup
    @display = Display.new(@board, Cursor.new([0, 0], @board))
    @player1 = HumanPlayer.new("Human1", :white, @display)
    @player2 = HumanPlayer.new("Human2", :red, @display)
    @current_player = @player2
  end

  def play
    until @board.checkmate?(@player1.color) || @board.checkmate?(@player2.color)
      switch_player!
      begin
        move = @current_player.play_turn
        unless @board[move.first].color == @current_player.color
          raise "That is not your piece."
        end
        @board.move_piece(move.first, move.last)
      rescue StandardError => e
        puts e
        retry
        sleep(1)
      end
    end
    @display.render
    puts 'Game Over!'
    puts "Winner is #{@current_player.name}"
  end

  def switch_player!
    @current_player = @current_player == @player1 ? @player2 : @player1
  end

end

Game.new.play
