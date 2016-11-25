require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @num_buckets = 8
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    resize! if @count == @num_buckets

    unless self[key.hash].include?(key.hash)
      self[key.hash] << key.hash
      @count += 1
    end
  end

  def remove(key)
    if self[key.hash].include?(key.hash)
      self[key.hash].delete(key.hash)
      @count -= 1
    end
  end

  def include?(key)
    self[key.hash].include?(key.hash)
  end

  private

  def [](hash)
    @store[hash % @num_buckets]
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
