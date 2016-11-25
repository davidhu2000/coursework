def naive_max_range(arr, window)
  curr_max_range = nil
  (0..arr.length-window).each do |idx|
    diff = arr[idx...idx+window].minmax.inject(&:-).abs
    curr_max_range = diff if curr_max_range.nil? || diff > curr_max_range
  end
  curr_max_range
end

# class MinMaxStackQueue
#   def initialize(arr, window)
#     @max_diff = nil
#     @arr = arr
#     @window = window
#     @bob.populate
#     @current_idx = window
#     @min_val = nil
#     @max_val = nil
#   end
#
#   def populate
#     current = []
#     @window.times do |i|
#       @min_val = @arr[i] if min_val.nil? || @arr[i] < min_val
#       @max_val = @arr[i] if max_val.nil? || @arr[i] > max_val
#       current << @arr[i]
#     end
#     current
#   end
#
#   def next_window
#     @bob.shift
#     @bob << @arr[current_idx]
#     @current_idx += 1
#   end
#
#   def diff
#     @bob.max - @bob.min
#   end
#
#   def optimized_max_range
#
#   end
# end

class MyStack
  def initialize
    @store = []
  end

  def pop
    @store.pop
  end

  def push(x)
    @store.push(x)
  end

  def peek
    @store.last
  end

  def size
    @store.length
  end

  def empty?
    @store.empty?
  end
end





arr = [1, 0, 2, 5, 4, 8]
window = 2

start_time = Time.now

p naive_max_range(arr, window)

puts Time.now - start_time


# start_time = Time.now
#
# p hash_four_sum?(arr, target)
#
# puts Time.now - start_time
