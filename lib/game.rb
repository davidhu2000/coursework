require_relative 'deck'
require_relative 'player'

class Game
  attr_reader :deck, :players, :current_player, :pot

  def initialize(players)
    @deck = Deck.new
    @players = players
    @current_player = @players.first
    @pot = 0
  end

  def play
  end

  def take_turn

  end

  def deal
    5.times do
      @players.each do |player|
        player.hand.receive(@deck.deal!)
      end
    end
  end
end
