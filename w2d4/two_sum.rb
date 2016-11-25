def brutal_two_sum?(arr, target)
  arr.each_with_index do |x1, idx1|
    arr.each_with_index do |x2, idx2|
      next if idx1 == idx2
      return true if x1 + x2 == target
    end
  end
  return false
end
# O(n^2)
class Array
  def bsearch(target)
    return nil if self.empty?

     probe_index = self.length / 2
     case target <=> self[probe_index]
     when -1
       self.take(probe_index).bsearch(target)
     when 0
       probe_index
     when 1
       sub_answer = self.drop(probe_index + 1).bsearch(target)
       (sub_answer.nil?) ? nil : (probe_index + 1) + sub_answer
     end
  end
end

def sort_two_sum?(arr, target)
  arr2 = arr.sort!
  arr2.each_with_index do |x, idx|
    diff = target - x
    return true if arr.bsearch(diff)
  end
  false
end
# O(n*log(n))

def hash_two_sum?(arr, target)
  hash = Hash.new(0)
  arr.each do |el|
    hash[el] += 1
  end

  arr.each do |el|
    hash[el] -= 1
    return true if hash[target - el] > 0
    hash[el] += 1
  end

  false

end

def hash_four_sum?(arr, target)
  hash = Hash.new(0)
  arr.each do |el|
    hash[el] += 1
  end

  (1...target).each do |part|
    return true if hash_two_sum?(arr, part) && hash_two_sum?(arr, target - part)
  end
  false
end

arr = (1..2000).to_a
target = 2000 + 1999 + 1998 + 1997

start_time = Time.now

p brutal_two_sum?(arr, target) # => should be true

puts Time.now - start_time


start_time = Time.now

p sort_two_sum?(arr, target)

puts Time.now - start_time


start_time = Time.now

p hash_two_sum?(arr, target)

puts Time.now - start_time


start_time = Time.now

p hash_four_sum?(arr, target)

puts Time.now - start_time
