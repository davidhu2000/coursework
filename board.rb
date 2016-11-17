

class Board
  attr_reader :board

  def self.empty_board(height = 10, width = 10)
    Array.new(height) { Array.new(width) }
  end

  def self.seed_bombs(num_bombs = 10)
    board = self.empty_board

    placed = 0

    until placed == num_bombs

      row = rand(board.length)
      col = rand(board.first.length)



      unless board[row][col] == "\u1F4A3"
        board[row][col] = "\u1F4A3"
        placed += 1
      end

    end
    p board
  end

  def initialize(board)
    @board = board
  end



end

Board.seed_bombs
