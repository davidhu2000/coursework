require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap
  include Enumerable

  attr_reader :count

  def initialize(num_buckets = 8)
    @num_buckets = num_buckets
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    @store[bucket(key)].include?(key)
  end

  def set(key, val)
    resize! if @count == @num_buckets
    current_bucket = @store[bucket(key)]
    if current_bucket.include?(key)
      current_bucket.update(key, val)
    else
      current_bucket.append(key, val)
      @count += 1
    end
  end

  def get(key)
    @store[bucket(key)].get(key) if include?(key)
  end

  def delete(key)
    if include?(key)
      @store[bucket(key)].remove(key)
      @count -= 1
    end
  end

  def each
    @store.each do |list|
      list.each do |link|
        yield link.key, link.val
      end
    end
  end

  uncomment when you have Enumerable included
  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    @num_buckets *= 2
    new_store = Array.new(@num_buckets) { LinkedList.new }
    @store.each do |list|
      list.each do |link|
        new_store[bucket(link.key)].append(link.key, link.val)
      end
    end

    @store = new_store
  end

  def bucket(key)
    key.hash % @num_buckets
  end
end
