

class Board
  attr_reader :board
  DELTAS = [[-1, -1], [-1, 0], [-1, 1], [0, 1],
            [1, 1],   [1, 0],  [1, -1], [0, -1]].freeze

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
    board
  end

  def self.seed_numbers
    board = self.seed_bombs
    max_row = board.length - 1
    max_col = board.first.length - 1
    board.each_with_index do |row, row_idx|
      board.each_with_index do |el, col_idx|

        if board[row_idx][col_idx].nil?
          neighbors = find_neighbors(max_row, max_col, row_idx, col_idx)
        end
        
      end
    end

  end

  def self.find_neighbors(max_row, max_col, row_idx, col_idx)
    neighbors = DELTAS.map do |row_del, col_del|
      [row_idx + row_del, col_idx + col_del]
    end
    neighbors.select do |r_idx, c_idx|
      r_idx.between?(0, max_row) && c_idx.between?(0, max_col)
    end
  end

  def initialize(board)
    @board = board
  end



end

Board.seed_numbers
