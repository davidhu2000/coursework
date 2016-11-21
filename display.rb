require 'colorize'
require_relative 'board'
require_relative 'cursor'

class Display
  attr_accessor :board
  def initialize(board, cursor)
    @board = board
    @cursor = cursor
  end

  def render
    system('clear')
    board.grid.each_with_index do |row, row_idx|
      row.each_with_index do |tile, col_idx|

        if [row_idx, col_idx] == @cursor.cursor_pos
          print "#{tile} ".center(7)
                .colorize(:background => :light_white, :color => :red)
        else
          print "#{tile} ".center(7)
        end
      end
      puts
    end
  end
end

board = Board.new
cursor = Cursor.new([0, 0], board)
display = Display.new(board, cursor)

while true

  display.render
  cursor.get_input
end
