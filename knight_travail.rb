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
    possible_moves.reject! { |pos| @visited_positions.include?(pos) }
    possible_moves.each do |pos|
      @visited_positions << pos
    end
    possible_moves
  end


end

path = KnightPathFinder.new([0, 0])
path.build_move_tree
p path.pos_node.children.first.children.length
