require_relative 'tic_tac_toe'


class TicTacToeNode

  attr_reader :board, :next_mover_mark, :prev_move_pos
  attr_accessor :parent, :children
  MARKS = [:x, :o]

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
    @parent = nil
    # @children = []
  end

  def losing_node?(evaluator)
  end

  def winning_node?(evaluator)
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    possible_moves = []
    board.rows.each_with_index do |row, i|
      row.each_with_index do |el, j|
        possible_moves << [i, j] if el.nil?
      end
    end
    total_children = []

    possible_moves.each do |move|
      dup_board = board.dup
      dup_board[move] = @next_mover_mark
      child_mover_mark = switch_mark
      node = TicTacToeNode.new(dup_board, child_mover_mark, move)
      node.parent = self
      total_children << node
    end
    total_children
  end

  def switch_mark
    (@next_mover_mark == :x ? :o : :x)
  end
end
# empty_board_node = TicTacToeNode.new(Board.new, :x)
# empty_board_node.board[[0, 0]] = :x
# empty_board_node.board[[0, 1]] = :o
# kids = empty_board_node.children.map{ |kid| kid.prev_move_pos }
# expect(kids.include?([0, 0])).to eq(false)
# expect(kids.include?([0, 1])).to eq(false)
