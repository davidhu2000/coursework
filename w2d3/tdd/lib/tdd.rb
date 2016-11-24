require 'byebug'

class Array
  def my_uniq
    result = []

    self.each do |el|
      result << el unless result.include?(el)
    end

    result

  end

  def two_sum
    result = []

    (0...self.length - 1).each do |i|
      (i + 1..self.length - 1).each do |j|
        result << [i, j] if self[i] + self[j] == 0
      end
    end

    result

  end

  def my_transpose
    res = Array.new(self.length) { Array.new(self.first.length)}

    self.each_with_index do |row, row_idx|
      row.each_with_index do |el, col_idx|
        res[col_idx][row_idx] = el
      end
    end
    res
  end
end

def stock_picker(prices)
  max_price = prices.max

  max_price_day = prices.index(max_price)
  min_price = prices[0...max_price_day].min
  min_price_day = prices.index(min_price)

  [min_price_day, max_price_day]
end



class TowersOfHanoi

  attr_accessor :towers

  def initialize
    @towers = [[3,2,1], [], []]
  end

  def play
    until won?
      move(get_input)
    end
  end

  def get_input
    # puts 'Enter the position you want to move from and to: '
    pos = gets.chomp.split(',').map(&:to_i)
    raise "Not valid position" unless pos.all? { |c| c.between?(0, 2) }
    raise "No disc in starting position" if @towers[pos.first].empty?

    from_disc = @towers[pos.first].last
    if !@towers[pos.last].empty? && @towers[pos.last].last < from_disc
      raise "Cannot place larger disk onto smaller disk"
    end

    pos
  end

  def move(pos)
    @towers[pos.last] << @towers[pos.first].pop
  end

  def won?
    @towers.drop(1).any? { |tower| tower.length == 3}
  end
end
