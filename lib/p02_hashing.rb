class Object
  ALPHANUM= '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'
  def self.hash_class_name(class_name)
    hash_value = 0
    class_name.to_s.downcase.each_char do |char|
      hash_value += ALPHANUM.index(char).hash
    end
    hash_value
  end
end
class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    hash_value = Object.hash_class_name(self.class)
    self.each_with_index do |el, idx|
      current_hash = idx.hash
      if [Integer, Array, Hash, Fixnum].include?(el.class)
        current_hash *= el.hash
      else
        el = 0.to_s if el.nil?
        current_hash *= Object::ALPHANUM.index(el)
      end
      hash_value += current_hash
    end
    hash_value
  end
end

class String
  def hash
    hash_value = Object.hash_class_name(self.class)
    hash_value + self.chars.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    hash_array = self.sort_by { |k, _| k }
    hash_value = Object.hash_class_name(self.class)
    hash_array.each_with_index do |el, idx|
      hash_value += idx.hash * el.map(&:to_s).hash
    end
    hash_value
  end
end
