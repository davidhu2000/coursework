def sum_recur(array)
  return 0 if array.empty?

  array.first + sum_recur(array.drop(1))
end

p sum_recur([1, 2, 3, 4, 5]) == 15

def includes?(array, target)
  return false if array.empty?

  return true if array.pop == target
  includes?(array, target)
end

p includes?([1, 2, 3, 4, 5], 5)
p includes?([1, 2, 3, 4, 5], 6) == false

def num_occur(array, target)
  return 0 if array.empty?
  count = 0

  count = 1 if array.pop == target

  count += num_occur(array, target)

  count
end

p num_occur([1, 1, 2, 3], 1) #== 4
p num_occur([1, 2, 3, 1, 2, 5, 3, 4, 6, 7, 5, 3, 3], 1) #== 0

def add_to_twelve?(array)
  return false if array.length == 1

  first = array.shift
  return true if first + array.first == 12

  add_to_twelve?(array)
end

p add_to_twelve?([1, 2, 9, 3, 4, 8])
p add_to_twelve?([1, 2, 4, 5, 6, 8])

def sorted?(array)
  return true if array.length == 1

  first = array.shift
  return false if first > array.first
  sorted?(array)
end

p sorted?((1..9).to_a.shuffle)
p sorted?((1..9).to_a)


def reverse(string)
  return string if string.length == 1
  reverse(string[1..-1]) + string[0]
end

p reverse('hello')
p reverse('whats up')
