require 'colorize'
require_relative 'board'
require_relative 'cursor'

class Display
  attr_accessor :board, :cursor
  BAR = "-" * 52
  HEADING = "      " + ('a'..'h').to_a.join('     ')

  def initialize(board, cursor)
    @board = board
    @cursor = cursor
  end

  def render
    system('clear')
    puts HEADING
    
    board.grid.each_with_index do |row, row_idx|
      puts BAR
      print "#{row_idx}  |"

      row.each_with_index do |tile, col_idx|

        if [row_idx, col_idx] == @cursor.cursor_pos
          print "#{tile} ".center(5)
            .colorize(background: :light_white, color: :red)
        else
          print "#{tile} ".center(5).colorize(color: tile.color)
        end
        print "|"
      end
      puts
    end
    puts BAR
  end
end
