require 'byebug'

class PolyTreeNode
  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent
    @parent
  end

  def children
    @children
  end

  def value
    @value
  end

  def parent=(node)
    @parent.children.delete(self) if @parent

    if node.nil?
      @parent = nil
    else
      @parent = node
      node.children << self
    end

  end

  def add_child(node)
    # debugger
    unless @children.include?(node)
      puts "here"
      # @children << node
      node.parent = self
    end
  end

  def remove_child(node)
    if @children.include?(node)
      node.parent = nil
      @children.reject! { |child| child == node }
    else
      raise "Not a child"
    end
  end

  def dfs(target)
    return self if self.value == target

    stack = []
    @children.each do |child|
      var = child.dfs(target)
      return var if var
    end
    nil
  end

  def bfs(target)
    queue = [self]
    until queue.empty?
      current = queue.shift
      return current if current.value == target
      current.children.each do |child|
        queue << child
      end
    end

    nil
  end

end

root = PolyTreeNode.new("root")
node1 = PolyTreeNode.new(1)
node2 = PolyTreeNode.new(2)
root.add_child(node1)
p root.children
root.add_child(node1)
p root.children
