
class HumanPlayer
  attr_reader :name, :color
  
  def initialize(color, name = "Human")
    @name = name
    @color = color
  end
end
