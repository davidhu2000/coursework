require 'colorize'

class Tile
  attr_accessor :revealed
  attr_reader :value

  def initialize(value)
    @value = value
    @revealed = false
    @flagged = false
  end
end
