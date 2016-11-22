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
      p @move
      begin
        get_move
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

  # def move_piece
  #   if @move.length == 2
  #     piece = @board[@move.first]
  #     p piece.class
  #     p piece.moves
  #     possible_moves = piece.moves
  #
  #     if possible_moves.include? @move.last
  #       @board[@move.first] = NullPiece.instance
  #       @board[@move.last] = piece
  #     end
  #
  #     @move = []
  #   end
  # end
end

Game.new.play
