require 'byebug'

def range_recursive(start_num, num)
  return [] if num < start_num
  range_recursive(start_num, num - 1).concat([num])
end

def range_iterative(start_num, end_num)
  res = []
  idx = start_num
  while idx <= end_num
    res << idx
    idx += 1
  end
  res
end

def exp1(base, power)
  return 1 if power.zero?
  if power < 0
    1.fdiv(base) * exp1(base, power + 1)
  else
    base * exp1(base, power - 1)
  end
end

# p exp1(2, 2)
# p exp1(-3, 2)
# p exp1(2, -2)

def exp2(base, power)
  return 1 if power.zero?
  if power < 0
    # 1.fdiv(base) * exp1(base, power + 1)
  else
    if power.odd?
      base * exp1(base, power / 2) * exp1(base, power / 2)
    else
      exp1(base, power / 2) * exp1(base, power / 2)
    end
  end
end

# p exp2(2, 5)
# p exp2(-3, 2)
# p exp2(2, -2)

class Array
  def deep_dup
    return self if self.length <= 1
    dup_array = []
    self.each do |el|
      if el.is_a? Array
        dup_array << el.deep_dup
      else
        dup_array << el
      end
    end
    dup_array
  end
end

robot_parts = [
  ["nuts", "bolts", "washers"],
  ["capacitors", "resistors", "inductors"]
]
#
# robot_parts_copy = robot_parts.deep_dup
# p robot_parts
# p robot_parts_copy
#
# robot_parts_copy[0][0] = "testing"
# p robot_parts
# p robot_parts_copy
# p robot_parts[0][0]

# arr = [1, [2], [3, [4]]]
#
# arr_dup = arr.deep_dup
#
# p arr_dup
# arr_dup[2][0] = 8
# p arr_dup
# p arr

# def fibonacci(n)
#   return 1 if n == 2
#   return 1 if n <= 1
#
#   fibonacci(n - 1) + fibonacci(n - 2)
# end

def fibonacci(n)
  return [1, 1] if n == 2
  return [1] if n <= 1
  prev_step = fibonacci(n - 1)
  prev_step << prev_step[-2..-1].inject(:+)
end

# p fibonacci(6)

def permutations(array)

  return array if array.length == 1
  res = []
  array.each_with_index do |el, idx|
    current_perm = [el]
    perm_subarray = array[0...idx].concat(array[idx + 1..-1])

    permutations(perm_subarray).map do |subarr|
      if subarr.is_a? Array
        current_perm.concat(subarr)
      else
        current_perm << subarr
      end
      res << current_perm
      current_perm = [el]
    end

  end
  res
end

# p permutations([1, 2, 3, 4]).count

# def bsearch(array, target)
#   return nil if array.length == 1 && array.first != target
#
#   middle_idx = array.length / 2
#   middle_val = array[middle_idx]
#
#   if target == middle_val
#     middle_val
#   elsif target > middle_val
#     array.index(bsearch(array.drop(middle_idx + 1), target))
#   else
#     array.index(bsearch(array.take(middle_idx), target))
#   end
# end

# def bsearch(array, target)
#
#   return nil if array.length == 1 && array.first != target
#
#   middle_idx = array.length / 2
#   middle_val = array[middle_idx]
#
#   total_idx = middle_idx
#
#   if target > middle_val
#
#     subarray = array.drop(middle_idx + 1)
#     return_idx = bsearch(subarray, target)
#     return nil unless return_idx
#     total_idx += return_idx + 1
#
#   elsif target < middle_val
#
#     subarray = array.take(middle_idx)
#     total_idx -= 1 if subarray.length == 1
#     return_idx = bsearch(subarray, target)
#     return nil unless return_idx
#     total_idx -= return_idx
#
#   else
#     middle_idx
#   end
#   total_idx
# end

def bsearch(array, target)
  return nil if array.length == 1 && array.first != target
  return 0 if array.length == 1

  middle_idx = array.length / 2
  middle_val = array[middle_idx]

  left_sub = array.take(middle_idx)
  right_sub = array.drop(middle_idx + 1)

  if target > middle_val
    subidx = bsearch(right_sub, target)
    return nil unless subidx
    left_sub.length + subidx + 1
  elsif target < middle_val
    subidx = bsearch(left_sub, target)
    return nil unless subidx
    subidx
  else
    middle_idx
  end
  # total_idx
end

# p bsearch([1, 2, 3], 1) # => 0
# p bsearch([2, 3, 4, 5], 3) # => 1
# p bsearch([2, 4, 6, 8, 10], 6) # => 2
# p bsearch([1, 3, 4, 5, 9], 5) # => 3
# p bsearch([1, 2, 3, 4, 5, 6], 6) # => 5
# p bsearch([1, 2, 3, 4, 5, 6], 0) # => nil
# p bsearch([1, 2, 3, 4, 5, 7], 6) # => nil
# p bsearch((1..100_000_000).to_a, 12_543_453) # => nil

def merge(arr1, arr2)
  result = []
  until arr1.empty? || arr2.empty?
    if arr1.first < arr2.first
      result << arr1.shift
    else
      result << arr2.shift
    end
  end

  result.concat(arr1).concat(arr2)
end

def merge_sort(array)
  return array if array.length <= 1

  left = array.take(array.length / 2)
  right = array.drop(array.length / 2)

  merge(merge_sort(left), merge_sort(right))
end

# array = [2, 5, 6, 4, 3, 1]
# # array = (1..9).to_a.shuffle
# p merge_sort(array)

def subsets(array)
  return [[]] if array.empty?

  last_el = array.last

  result = subsets(array[0..-2])
  result.dup.each do |el|
    result << (el.dup << last_el)
  end
  result
end

# p subsets([]) # => [[]]
# p subsets([1]) # => [[], [1]]
# p subsets([1, 2]) # => [[], [1], [2], [1, 2]]
# p subsets([1, 2, 3])
# # => [[], [1], [2], [1, 2], [3], [1, 3], [2, 3], [1, 2, 3]]

# def greedy_make_change(total, coin_value)
#   res = []
#   coin_value.each do |coin|
#     until total < coin
#       total -= coin
#       res << coin
#     end
#   end
#   res
# end

# def greedy_make_change(total, coin_value)
#   return if total == 0
#   res = []
#
#   current_coin = coin_value.first
#
#   if total / current_coin > 0
#     res << current_coin
#     total -= current_coin
#     res.concat(greedy_make_change(total, coin_value))
#   else
#     res.concat(greedy_make_change(total, coin_value[1..-1]))
#   end
#
#   res
#
# end

def greedy_make_change(total, coin_values)
  return [] if total == 0

  coin = coin_values.find { |cn| total / cn > 0 }

  [coin].concat(greedy_make_change(total - coin, coin_values))
end

# p greedy_make_change(24, [10, 7, 1]) #=> [10, 10, 1, 1, 1, 1]

# def make_better_change(total, coin_values)
#   return [] if total == 0
#
#   combos = []
#
#   coin_values.each do |cn|
#     next if total - cn < 0
#     combos << [cn].concat(make_better_change(total - cn, coin_values))
#   end
#
#   p combos
#
#   return [] if combos.empty?
#   combos.min_by(&:length)
# end



# def make_better_change(total, coin_values)
#   return [[]] if total == 0
#
#   combos = []
#
#   coin_values.each do |cn|
#     next if total - cn < 0
#     current_combo = []
#     temp_combos = make_better_change(total - cn, coin_values)
#     # p temp_combos
#     temp_combos.each do |combo|
#       # p combo
#       current_combo = [cn].concat(combo)
#       combos << current_combo
#
#     end
#
#     # gets
#   end
#   # combos
#   # combos.each { |combo| p combo }
#
#   combos.min_by(&:length)
# end

def make_better_change(total, coins)
  return [] if total.zero?

  best_guess = nil
  coins = coins.sort.reverse

  coins.each_with_index do |coin, idx|
    next if coin > total

    this_guess = [coin] + make_better_change(total - coin, coins.drop(idx))

    if best_guess.nil? || this_guess.length < best_guess.length
      best_guess = this_guess
    end
  end
  best_guess
end

p make_better_change(105, [10, 7, 1])

# p make_better_change(1, [10, 7, 1])
