require 'colorize'

class Board
  attr_reader :rows

  def self.blank_grid
    Array.new(3) { Array.new(3) }
  end

  def initialize(rows = self.class.blank_grid)
    @rows = rows
  end

  def [](pos)
    row = pos[0]
    col = pos[1]
    @rows[row][col]
  end

  def []=(pos, mark)
    raise 'mark already placed there!' unless empty?(pos)

    row = pos[0]
    col = pos[1]
    @rows[row][col] = mark
  end

  def cols
    cols = [[], [], []]
    @rows.each do |row|
      row.each_with_index do |mark, col_idx|
        cols[col_idx] << mark
      end
    end

    cols
  end

  def diagonals
    down_diag = [[0, 0], [1, 1], [2, 2]]
    up_diag = [[0, 2], [1, 1], [2, 0]]

    [down_diag, up_diag].map do |diag|
      # Note the `row, col` inside the block; this unpacks, or
      # "destructures" the argument. Read more here:
      # http://tony.pitluga.com/2011/08/08/destructuring-with-ruby.html
      diag.map { |row, col| @rows[row][col] }
    end
  end

  def dup
    duped_rows = rows.map(&:dup)
    self.class.new(duped_rows)
  end

  def empty?(pos)
    self[pos].nil?
  end

  def tied?
    return false if won?

    # no empty space?
    @rows.all? { |row| row.none?(&:nil?) }
  end

  def over?
    # don't use Ruby's `or` operator; always prefer `||`
    won? || tied?
  end

  def winner
    (rows + cols + diagonals).each do |triple|
      return :x if triple == [:x, :x, :x]
      return :o if triple == [:o, :o, :o]
    end

    nil
  end

  def won?
    !winner.nil?
  end
end

# Notice how the Board has the basic rules of the game, but no logic
# for actually prompting the user for moves. This is a rigorous
# decomposition of the "game state" into its own pure object
# unconcerned with how moves are processed.

class TicTacToe
  class IllegalMoveError < RuntimeError
  end

  attr_reader :board, :players, :turn

  def initialize(player1, player2)
    @board = Board.new
    @players = { x: player1, o: player2 }
    @turn = :x
  end

  def run
    play_turn until board.over?
    show
    if board.won?
      winning_player = players[board.winner]
      puts "#{winning_player.name} won the game!"
    else
      puts 'No one wins!'
    end
  end

  def show
    # not very pretty printing!
    puts
    board.rows.each_with_index do |row, row_idx|
      row.each_with_index do |el, col_idx|
        color = el == :x ? :cyan : :red
        print (el.nil? ? ' ' : el.to_s).colorize(color)
        print ' | ' unless col_idx == row.length - 1

      end
      puts
      puts '-' * 10 unless row_idx == board.rows.length - 1
    end
    puts
  end

  private

  def place_mark(pos, mark)
    if board.empty?(pos)
      board[pos] = mark
      true
    else
      false
    end
  end

  def play_turn
    loop do
      current_player = players[turn]
      pos = current_player.move(self, turn)

      break if place_mark(pos, turn)
    end

    # swap next whose turn it will be next
    @turn = (turn == :x ? :o : :x)
  end
end

class HumanPlayer
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def move(game, _mark)
    game.show
    loop do
      puts "#{@name}: please select your space"
      row, col = gets.chomp.split(',').map(&:to_i)
      if HumanPlayer.valid_coord?(row, col)
        return [row, col]
      else
        puts 'Invalid coordinate!'
      end
    end
  end

  private

  def self.valid_coord?(row, col)
    [row, col].all? { |coord| (0..2).cover?(coord) }
  end
end

class ComputerPlayer
  attr_reader :name

  def initialize
    @name = 'Tandy 400'
  end

  def move(game, mark)
    winner_move(game, mark) || random_move(game)
  end

  private

  def winner_move(game, mark)
    (0..2).each do |row|
      (0..2).each do |col|
        board = game.board.dup
        pos = [row, col]

        next unless board.empty?(pos)
        board[pos] = mark

        return pos if board.winner == mark
      end
    end

    # no winning move
    nil
  end

  def random_move(game)
    board = game.board
    loop do
      range = (0..2).to_a
      pos = [range.sample, range.sample]

      return pos if board.empty?(pos)
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  puts 'Play the dumb computer!'
  hp = HumanPlayer.new('Ned')
  cp = ComputerPlayer.new

  TicTacToe.new(hp, cp).run
end
