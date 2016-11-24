require_relative 'hand'

class Player
  attr_reader :name, :hand, :folded
  attr_accessor :chips

  def initialize(name, chips)
    @name = name
    @hand = Hand.new
    @chips = chips
    @folded = false
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

  def get_action
    action = $stdin.gets.chomp
    raise "Invalid Action" unless %w(f c r).include?(action[0])
    action[0]
  end

  def do_action(bet)
    action = get_action
    if action == 'f'
      @folded = true
    elsif action == 'c'
      @chips -= bet
    else
      # puts "Enter raised bet: "
      player_raise = bet
      until player_raise > bet
        player_raise = $stdin.gets.chomp.to_i
      end
      @chips -= player_raise
      return player_raise
    end
    nil
  end

  private

  def has_card?(suit, value)
    hand.cards.any? do |card|
      card.value == value && card.suit == suit
    end
  end

end
