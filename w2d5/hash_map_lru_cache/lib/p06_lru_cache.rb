require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    if @map.include?(key)
      link = @map.get(key)
      update_link!(link)
    else
      calc!(key)
      eject! if @map.count > @max
    end
    @map.get(key).val
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    value = @prc.call(key)
    link = @store.append(key, value)
    @map.set(key, link)
  end

  def update_link!(link)
    @store.remove(link.key)
    @store.append(link.key, link.val)
  end

  def eject!
    key = @store.head.next.key
    @store.remove(key)
    @map.delete(key)
  end
end
