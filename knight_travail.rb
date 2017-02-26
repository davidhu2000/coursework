require_relative 'tree_node'

class KnightPathFinder
  DELTAS = [[-2, -1], [-2,  1], [-1,  2], [ 1,  2],
            [ 2,  1], [ 2, -1], [ 1, -2], [-1, -2]].freeze

  def self.valid_moves(pos)
    row, col = pos
    moves = DELTAS.map do |row_delta, col_delta|
      [row + row_delta, col + col_delta]
    end

    moves.select do |m_row, m_col|
      m_row.between?(0, 7) && m_col.between?(0, 7)
    end

  end

  attr_accessor :pos_node

  def initialize(position)
    @pos_node = PolyTreeNode.new(position)
    @visited_positions = [position]
    build_move_tree
  end

  def build_move_tree
    queue = [@pos_node]
    until queue.empty?
      current_node = queue.shift

      possible_moves = new_move_positions(current_node.value)
      possible_moves.each do |move|
        node = PolyTreeNode.new(move)
        node.parent = current_node
        queue << node
      end
    end
  end

  def new_move_positions(pos)
    possible_moves = self.class.valid_moves(pos)
    possible_moves.reject! { |move| @visited_positions.include?(move) }

    possible_moves.each { |move| @visited_positions << move }

    possible_moves
  end

  def find_path(end_pos)
    final_node = @pos_node.bfs(end_pos)
    trace_path_back(final_node)
  end

  def trace_path_back(final_node)
    path = [final_node.value]
    node = final_node.parent

    until node.parent.nil?
      path << node.value
      node = node.parent
    end
    path << @pos_node.value
    path.reverse
  end

end
