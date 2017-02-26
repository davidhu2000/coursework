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
  end

  def losing_node?(evaluator)
    if board.over?
      board.won? && board.winner != evaluator
    elsif self.next_mover_mark == evaluator
      self.children.all? { |child| child.losing_node?(evaluator)}
    else
      self.children.any? { |child| child.losing_node?(evaluator)}
    end
  end

  def winning_node?(evaluator)
    if board.over?
      board.winner == evaluator
    elsif self.next_mover_mark == evaluator
      self.children.any? { |child| child.winning_node?(evaluator)}
    else
      self.children.all? { |child| child.winning_node?(evaluator)}
    end
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
