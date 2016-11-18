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

    @children.each do |child|
      current_node = child.dfs(target)
      return current_node if current_node
    end
    nil
  end

  def bfs(target)
    queue = [self]
    until queue.empty?
      current_node = queue.shift
      return current_node if current_node.value == target
      current_node.children.each do |child|
        queue << child
      end
    end

    nil
  end

end
