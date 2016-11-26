require 'colorize'
require_relative 'board'
require_relative 'cursor'

class Display
  attr_accessor :board, :cursor, :selected
  BAR = "   "+ "-" * 41
  HEADING = "     " + ('a'..'h').to_a.join('    ')

  def initialize(board, cursor)
    @board = board
    @cursor = cursor
    @selected = []
  end

  def render
    system('clear')
    puts HEADING

    board.grid.each_with_index do |row, row_idx|
      puts BAR
      print " #{row_idx} |"

      row.each_with_index do |tile, col_idx|

        if [row_idx, col_idx] == @cursor.cursor_pos
          print tile.to_s.center(4)
            .colorize(background: :cyan, color: tile.color)
        elsif [row_idx, col_idx] == selected
          print tile.to_s.center(4).colorize(background: :light_red, color: tile.color)
        else
          print tile.to_s.center(4)
        end
        print "|"
      end
      puts
    end
    puts BAR
  end
end
