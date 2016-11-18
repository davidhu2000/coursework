require_relative 'tree_node'

class KnightPathFinder
  DELTAS = [
    [-2, -1],
    [-2, 1],
    [-1, 2],
    [1, 2],
    [2, 1],
    [2, -1],
    [1, -2],
    [-1, -2]
  ].freeze

  def self.valid_moves(pos)
    row, col = pos
    moves = DELTAS.map do |drow, dcol|
      [row + drow, col + dcol]
    end
    moves.select { |row, col| row.between?(0, 7) && col.between?(0, 7)}
  end

  attr_accessor :pos_node

  def initialize(position)
    @pos_node = PolyTreeNode.new(position)
    @visited_positions = [position]
    build_move_tree
  end

  def build_move_tree
    queue = [@pos_node]
    count = 0
    until queue.empty?
      current_node = queue.shift

      possible_moves = new_move_positions(current_node.value)
      possible_moves.each do |move|
        node = PolyTreeNode.new(move)
        node.parent = current_node
        queue << node
        count += 1
        if count >= 400
          queue = []
          break
        end
      end
    end
  end


  def new_move_positions(pos)
    possible_moves = self.class.valid_moves(pos)
    # possible_moves.reject! { |pos| @visited_positions.include?(pos) }
    # possible_moves.each do |pos|
    #   @visited_positions << pos
    # end
    possible_moves
  end

  def find_path(end_pos)
    final_node = @pos_node.bfs(end_pos)
    # p final_node
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

path = KnightPathFinder.new([5, 5])
p path.find_path([6, 7])
