require 'colorize'

class Board
  attr_accessor :grid

  DELTAS = [[-1, -1], [-1, 0], [-1, 1], [0, 1],
            [1, 1],   [1, 0],  [1, -1], [0, -1]].freeze

  def empty_board(height, width)
    Array.new(height) { Array.new(width) }
  end

  def initialize(height = 10, width = 10, num_bombs = 10)
    @grid = empty_board(height, width)
    @height = height
    @width = width
    @num_bombs = num_bombs

    @grid = seed_bombs
    @grid = seed_numbers
    p @grid
  end

  def [](row, col)
    grid[row][col]
  end

  def []=(row, col, value)
    grid[row][col] = value
  end

  def render
    puts "    #{(0..grid.first.length - 1).to_a.join('   ')}  "
            .colorize(:color => :black, :background => :light_white)

    puts ("---" + "----" * grid.first.length).colorize(:light_white)
    grid.each_with_index do |row, idx|
      print "#{idx} ".colorize(:color => :black, :background => :light_white)
      print "|".colorize(:light_white)
      row.each do |el|
        print "#{el.to_s.rjust(2)} "
        print "|".colorize(:light_white)
      end
      puts
      puts ("---" + "----" * grid.first.length).colorize(:light_white)
    end
  end

  private

  def seed_bombs
    placed = 0
    until placed == @num_bombs
      row = rand(grid.length)
      col = rand(grid.first.length)

      unless grid[row][col] == "\u1F4A3"
        grid[row][col] = "\u1F4A3"
        placed += 1
      end

    end
    grid
  end

  def seed_numbers
    grid.each_with_index do |row, row_idx|
      grid.each_with_index do |el, col_idx|

        if grid[row_idx][col_idx].nil?
          neighbors = find_neighbors(row_idx, col_idx)
          grid[row_idx][col_idx] = cell_value(neighbors)
        end

      end
    end

  end

  def find_neighbors(row_idx, col_idx)
    neighbors = DELTAS.map do |row_del, col_del|
      [row_idx + row_del, col_idx + col_del]
    end

    max_row = grid.length - 1
    max_col = grid.first.length - 1

    neighbors.select do |r_idx, c_idx|
      r_idx.between?(0, max_row) && c_idx.between?(0, max_col)
    end
  end

  def cell_value(neighbors)
    neighbors.count do |row_idx, col_idx|
      grid[row_idx][col_idx] ==  "\u1F4A3"
    end
  end



end

Board.new(10,10,10).render
