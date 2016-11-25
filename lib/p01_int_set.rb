require 'byebug'

class MaxIntSet
  def initialize(max)
    @max = max
    @store = Array.new(max, false)
  end

  def insert(num)
    raise 'Out of bounds' unless is_valid?(num)
    @store[num] = true
  end

  def remove(num)
    @store[num] = false unless is_valid?(num)
  end

  def include?(num)
    @store[num]
  end

  private

  def is_valid?(num)
    num >= 0 && num < @max
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    self[num] << num unless self[num].include?(num)
  end

  def remove(num)
    self[num].delete(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @num_buckets = num_buckets
    @count = 0
  end

  def insert(num)
    resize! if @count == @num_buckets
    unless self[num].include?(num)
      self[num] << num
      @count += 1
    end
  end

  def remove(num)
    if self[num].include?(num)
      self[num].delete(num)
      @count -= 1
    end
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    @store[num % @num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    @num_buckets *= 2
    new_store = Array.new(@num_buckets) { [] }
    @store.flatten.each do |el|
      new_store[el % @num_buckets] << el
    end
    @store = new_store
  end
end
