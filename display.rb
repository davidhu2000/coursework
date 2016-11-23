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
    puts "      " + ('a'..'h').to_a.join('     ')
    board.grid.each_with_index do |row, row_idx|
      puts "-" * 52
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
    puts "-" * 52
  end
end
