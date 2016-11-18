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
    unless @children.include?(node)
      @children << node
      node.parent = self
    end
  end

  def remove_child(node)
    node.parent = nil
    @children.reject! { |child| child == node }
  end

end
