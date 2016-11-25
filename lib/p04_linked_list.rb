class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    self.prev.next = self.next
    self.next.prev = self.prev
    @next = nil
    @prev = nil
  end
end

class LinkedList
  include Enumerable

  def initialize
    @head = Link.new
    @tail = Link.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail && @tail.prev == @head
  end

  def get(key)
    loop_link(key).val
  end

  def include?(key)
    loop_link(key) != @tail
  end

  def append(key, val)
    link = Link.new(key, val)
    link.next = @tail
    link.prev = @tail.prev
    @tail.prev = link
    link.prev.next = link
  end

  def loop_link(key)
    place = @head.next
    until place.key == key || place == @tail
      place = place.next
    end
    place
  end

  def update(key, val)
    link = loop_link(key)
    link.val = val unless link == @tail
  end

  def remove(key)
    link = loop_link(key)
    raise "No key in list" if link == @tail
    link.remove
  end

  def each
    place = @head.next
    until place == @tail
      yield place
      place = place.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
