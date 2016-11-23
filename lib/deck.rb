require_relative 'card'

class Deck
  SUITS = [:spade, :heart, :club, :diamond]
  VALUES = [:a] + (2..13).to_a

  attr_reader :cards


  def intialize
    @cards = create_deck
  end

  def create_deck

  end

end
