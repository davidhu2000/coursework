require_relative 'hand'

class Player
  attr_reader :name, :amount, :hand

  def initialize(name, amount)
    @name = name
    @hand = Hand.new
    @amount = amount
  end

  def get_discard
    # puts "Enter in the suit and card value that you want to discard: "
    suit, value = $stdin.gets.chomp.split(/\s*,\s*/)
    suit = suit.to_sym
    value = value == 'a' ? value.to_sym : value.to_i

    raise 'card not in hand' unless has_card?(suit, value)

    [suit, value]
  end

  def discard_card
    suit, value = get_discard

    @hand.discard(suit, value)
  end

  def check_valid_input

  end

  private

  def has_card?(suit, value)
    hand.cards.any? do |card|
      card.value == value && card.suit == suit
    end
  end

end
