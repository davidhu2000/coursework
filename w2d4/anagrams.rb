def p1_anagram?(word1, word2)
  word1.chars.permutation.to_a.map(&:join).include?(word2)
end

def p2_anagram?(word1, word2)
  idx = word1.length - 1

  until idx < 0
    ltr = word1[idx]
    if word2.include? ltr
      word1.delete!(ltr)
      word2.delete!(ltr)
    end
    idx = word1.length - 1

  end

  word1.empty? && word2.empty?
end

class Array
  def quick_sort
    return self if self.length < 2
    val = self.first
    left = self[1..-1].select { |x| x < val }.quick_sort
    right = self[1..-1].select { |x| x >= val }.quick_sort
    left + [val] + right
  end
end

def p3_anagram?(word1, word2)
  word1.chars.quick_sort == word2.chars.quick_sort
end

def p3_anagram_def(word1, word2)
  word1.chars.sort == word2.chars.sort
end

def p4_anagram?(word1, word2)
  hash = Hash.new(0)
  (0...word1.length).each do |idx|
    hash[word1[idx]] += 1
    hash[word2[idx]] += 1
  end

  hash.none? { |_, v| v.odd? }
end

word1 = 'elvis' * 800
word2 = 'lives' * 800

# start_time = Time.now
#
# p p1_anagram?(word1, word2)
#
# puts Time.now - start_time

# start_time = Time.now
#
# p p2_anagram?(word1, word2)
#
# puts Time.now - start_time

start_time = Time.now

p p3_anagram?(word1, word2)

puts Time.now - start_time

start_time = Time.now

p p3_anagram_def(word1, word2)

puts Time.now - start_time

start_time = Time.now

p p4_anagram?(word1, word2)

puts Time.now - start_time
