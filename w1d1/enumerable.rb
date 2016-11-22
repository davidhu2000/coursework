require 'byebug'

class Array
  def my_each(&prc)
    i = 0
    while i < self.length
      prc.call(self[i])
      i += 1
    end
    self
  end

  def my_select(&prc)
    res = []
    self.my_each do |num|
      if prc.call(num)
        res << num
      end
    end
    res
  end

  def my_reject(&prc)
    res = []
    self.my_each do |num|
      unless prc.call(num)
        res << num
      end
    end
    res
  end

  def my_any?(&prc)
    self.my_each do |num|
      if prc.call(num)
        return true
      end
    end
    false
  end

  def my_all?(&prc)
    self.my_each do |num|
      unless prc.call(num)
        return false
      end
    end
    true
  end

  def my_flatten
    # debugger
    res = []
    self.my_each do |el|
      if el.is_a? Array
        el.my_flatten.my_each do |num|
          res << num
        end
      else
        res << el
      end
    end
    res
  end

  def my_zip(*args)
    res = []
    self.each_with_index do |num, i|
      sub_arr = [num]

      args.each do |el|
        sub_arr << el[i]
      end

      res << sub_arr
    end
    res
  end

  def my_rotate(num_shift = 1)

    until num_shift > 0
      num_shift += self.length
    end

    arr = self.dup
    (num_shift % self.length).times { arr.push(arr.shift) }
    arr
  end

  def my_join(delimiter = '')
    res = ''
    self.my_each do |el|
      res += el
      res += delimiter
    end
    res[0...(res.length - delimiter.length)]
  end

  def my_reverse
    res = []
    self.my_each do |num|
      res.unshift(num)
    end
    res
  end
end

if __FILE__ == $PROGRAM_NAME
  # [1,2,3].my_each do |num|
  #   puts num
  # end.my_each do |num|
  #   puts num
  # end

  # a = [1,2,3]
  # p a.my_select { |num| num > 1}

  # a = [1, 2, 3]
  # p a.my_reject { |num| num > 1 } # => [1]
  # p a.my_reject { |num| num == 4 } # => [1, 2, 3]

  # a = [1, 2, 3]
  # p a.my_any? { |num| num > 1 } # => true
  # p a.my_any? { |num| num == 4 } # => false
  # p a.my_all? { |num| num > 1 } # => false
  # p a.my_all? { |num| num < 4 } # => true

  # p [3, [4, [5, 6]], [[[7]], 8]].my_flatten # => [1, 2, 3, 4, 5, 6, 7, 8]

  # a = [ 4, 5, 6 ]
  # b = [ 7, 8, 9 ]
  # p [1, 2, 3].my_zip(a, b) # => [[1, 4, 7], [2, 5, 8], [3, 6, 9]]
  # p a.my_zip([1,2], [8])   # => [[4, 1, 8], [5, 2, nil], [6, nil, nil]]
  # p [1, 2].my_zip(a, b)    # => [[1, 4, 7], [2, 5, 8]]
  #
  # c = [10, 11, 12]
  # d = [13, 14, 15]
  # p [1, 2].my_zip(a, b, c, d)    # => [[1, 4, 7, 10, 13], [2, 5, 8, 11, 14]]
  #
  # a = [ "a", "b", "c", "d" ]
  # p a.my_rotate         #=> ["b", "c", "d", "a"]
  # p a.my_rotate(2)      #=> ["c", "d", "a", "b"]
  # p a.my_rotate(-3)     #=> ["b", "c", "d", "a"]
  # p a.my_rotate(15)     #=> ["d", "a", "b", "c"]

  # a = [ "a", "b", "c", "d" ]
  # p a.my_join         # => "abcd"
  # p a.my_join("$")    # => "a$b$c$d"

  p [ "a", "b", "c" ].my_reverse   #=> ["c", "b", "a"]
  p [ 1 ].my_reverse               #=> [1]
end
