# ### Factors
#
# Write a method `factors(num)` that returns an array containing all the
# factors of a given number.

def factors(num)
  res = []
  (1..num).each do |x|
    if num % x == 0
      res << x
    end
  end
  res
end

# p factors(5) == [1,5]
# p factors(10) == [1,2,5,10]

# ### Bubble Sort
#
# http://en.wikipedia.org/wiki/bubble_sort
#
# Implement Bubble sort in a method, `Array#bubble_sort!`. Your method should
# modify the array so that it is in sorted order.
#
# > Bubble sort, sometimes incorrectly referred to as sinking sort, is a
# > simple sorting algorithm that works by repeatedly stepping through
# > the list to be sorted, comparing each pair of adjacent items and
# > swapping them if they are in the wrong order. The pass through the
# > list is repeated until no swaps are needed, which indicates that the
# > list is sorted. The algorithm gets its name from the way smaller
# > elements "bubble" to the top of the list. Because it only uses
# > comparisons to operate on elements, it is a comparison
# > sort. Although the algorithm is simple, most other algorithms are
# > more efficient for sorting large lists.
#
# Hint: Ruby has parallel assignment for easily swapping values:
# http://rubyquicktips.com/post/384502538/easily-swap-two-variables-values
#
# After writing `bubble_sort!`, write a `bubble_sort` that does the same
# but doesn't modify the original. Do this in two lines using `dup`.
#
# Finally, modify your `Array#bubble_sort!` method so that, instead of
# using `>` and `<` to compare elements, it takes a block to perform the
# comparison:
#
# ```ruby
# [1, 3, 5].bubble_sort! { |num1, num2| num1 <=> num2 } #sort ascending
# [1, 3, 5].bubble_sort! { |num1, num2| num2 <=> num1 } #sort descending
# ```
#
# #### `#<=>` (the **spaceship** method) compares objects. `x.<=>(y)` returns
# `-1` if `x` is less than `y`. If `x` and `y` are equal, it returns `0`. If
# greater, `1`. For future reference, you can define `<=>` on your own classes.
#
# http://stackoverflow.com/questions/827649/what-is-the-ruby-spaceship-operator

class Array
  def bubble_sort!(&prc)

    prc ||= Proc.new { |a, b| a <=> b }

    switched_any = true

    while switched_any
      switched_any = false
      self.each_with_index do |num, idx|
        next if idx.zero?
        if prc.call(self[idx-1], num) == 1
          self[idx-1], self[idx] = self[idx], self[idx-1]
          switched_any = true
        end
      end
    end
    self
  end

  def bubble_sort(&prc)
    arr = self.dup
    arr.bubble_sort!(prc)
  end
end

# arr = [1,2,3,4,5].shuffle
# arr.bubble_sort!
# p arr
#
# sorted = arr.bubble_sort! do |num1, num2|
#   # order numbers based on descending sort of their squares
#   num2**2 <=> num1**2
# end
#
# p sorted

# ### Substrings and Subwords
#
# Write a method, `substrings`, that will take a `String` and return an
# array containing each of its substrings. Don't repeat substrings.
# Example output: `substrings("cat") => ["c", "ca", "cat", "a", "at",
# "t"]`.
#
# Your `substrings` method returns many strings that are not true English
# words. Let's write a new method, `subwords`, which will call
# `substrings`, filtering it to return only valid words. To do this,
# `subwords` will accept both a string and a dictionary (an array of
# words).

def substrings(string)
  res = []

  (0...string.length).each do |i|
    substr = ""
    (i...string.length).each do |j|
      substr += string[j]
      res << substr unless res.include?(substr)
    end
  end
  res
end

p substrings("cat") == ["c", "ca", "cat", "a", "at", "t"]

def subwords(word, dictionary)
  dictionary.select do |dict_word|
    /#{dict_word}/ =~ word
  end

end

p words = subwords("asdfcatqwer", ["cat", "car"]) #=> ['cat']
p words = subwords("batcabtarbrat", ["cat", "car"]) #=> []
dictionary = ["bears", "ear", "a", "army"]
words = subwords("erbearsweatmyajs", dictionary)
p words #=> ["bears", "ear", "a"]
