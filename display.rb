require 'colorize'
require_relative 'board'
require_relative 'cursor'

class Display
  attr_accessor :board, :cursor, :selected
  BAR = '   ' + '-' * 41
  HEADING = '     ' + ('a'..'h').to_a.join('    ')

  PIECES = { King   => 1, Queen  => 1, Rook => 2,
             Knight => 2, Bishop => 2, Pawn => 8 }.freeze

  WHITE_UNICODE = { King => "\u2654", Queen  => "\u2658",
                    Rook => "\u2656", Knight => "\u2658",
                    Bishop => "\u2657", Pawn => "\u2659" }.freeze

  BLACK_UNICODE = { King => "\u265A", Queen  => "\u265B",
                    Rook => "\u265C", Knight => "\u265E",
                    Bishop => "\u265D", Pawn => "\u265F" }.freeze

  def initialize(board, cursor)
    @board = board
    @cursor = cursor
    @selected = []
  end

  def render
    system('clear')

    piece_moves = []
    piece_moves = @board[selected].moves unless selected.empty?
    
    captured_pieces(:white)

    puts HEADING

    board.grid.each_with_index do |row, row_idx|
      puts BAR
      print " #{row_idx} |"

      row.each_with_index do |tile, col_idx|
        if [row_idx, col_idx] == @cursor.cursor_pos
          print tile.to_s.center(4)
            .colorize(background: :cyan, color: tile.color)
        elsif [row_idx, col_idx] == selected
          print tile.to_s.center(4)
            .colorize(background: :light_red, color: tile.color)
        elsif piece_moves.include?([row_idx, col_idx])
          print tile.to_s.center(4)
            .colorize(background: :light_black, color: tile.color)
        else
          print tile.to_s.center(4)
        end
        print '|'
      end
      print " #{row_idx}"
      puts
    end
    puts BAR
    puts HEADING

    captured_pieces(:black)
  end

  def captured_pieces(color)
    unicode = Display.const_get("#{color.upcase}_UNICODE")

    pieces = @board.grid.flatten.select { |piece| piece.color == color }
    pieces_taken = PIECES.dup

    pieces.map!(&:class).each do |piece_class|
      pieces_taken[piece_class] -= 1
    end
    pieces_taken.select! { |_, v| v > 0 }

    print 'Captures: '
    pieces_taken.each do |piece_class, num_taken|
      num_taken.times { print "#{unicode[piece_class]} " }
    end
    puts
    puts
  end
end
