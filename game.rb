require_relative 'display'
require_relative 'human'

class Game

  def initialize
    @board = Board.setup
    @cursor = Cursor.new([0, 0], @board)
    @display = Display.new(@board, @cursor)
    @player1 = HumanPlayer.new("Human1", :white, @display)
    @player2 = HumanPlayer.new("Human2", :red, @display)
    @current_player = @player1
  end

  def play
    until @board.checkmate?(@player1.color) || @board.checkmate?(@player2.color)

      begin

        move = @current_player.play_turn
        unless @board[move.first].color == @current_player.color
          raise "That is not your piece."
        end
        
        @board.move_piece(move.first, move.last)
        p @current_player.name
        switch_player!
      rescue StandardError => e
        puts e

        sleep(1)
      end
    end

    puts 'Game Over!'
    puts "Winner is #{@current_player.name}"
  end

  def switch_player!
    @current_player = @current_player == @player1 ? @player2 : @player1
  end

end

Game.new.play
