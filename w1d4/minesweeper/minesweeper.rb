require_relative 'board'

class Minesweeper
  attr_accessor :board

  DEFAULT_VALUES = {easy: [8,8,10], medium: [16,16,40], hard: [24,24,99]}

  def self.game_setup
    puts "Enter a difficulty level"
    puts "(easy, medium, hard, custom)"
    print '>'

    difficulty = gets.chomp.downcase

    until difficulty =~ /^[emhc]/
      puts "Please put a valid level"
      difficulty = gets.chomp.downcase
    end

    case difficulty[0]
    when 'e'
      board = Board.new(*DEFAULT_VALUES[:easy])
    when 'm'
      board = Board.new(*DEFAULT_VALUES[:medium])
    when 'h'
      board = Board.new(*DEFAULT_VALUES[:hard])
    when 'c'
      board = Board.new(*get_custom_values)
    end

    game = self.new(board)

  end

  def self.get_custom_values
    puts "Enter number of desired bombs?"
    num_bombs = gets.chomp.to_i
    until num_bombs.between?(1, 500)
      puts "Please enter a number between 1 and 500"
      num_bombs = gets.chomp.to_i
    end

    case num_bombs
    when 1..10   then [8, 8, num_bombs]
    when 11..40  then [16, 16, num_bombs]
    when 41..500 then [24, 24, num_bombs]
    end

  end

  def initialize(board)
    @board = board
  end

end

game = Minesweeper.game_setup
game.board.render
