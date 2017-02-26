require_relative 'card'

class Deck
  SUITS = [:spade, :heart, :club, :diamond].freeze
  VALUES = [:a, 2, 3, 4, 5, 6, 7, 8, 9, :t, :j, :q, :k].freeze

  attr_reader :cards


  def initialize
    @cards = create_deck
  end

  def create_deck
    new_deck = []
    SUITS.each do |suit|
      VALUES.each do |value|
        new_deck << Card.new(value, suit)
      end
    end

    new_deck
  end

  def shuffle!
    @cards.shuffle!
  end

  def deal!
    @cards.shift
  end

  def reshuffle!
    @cards = create_deck
    shuffle!
  end

end
