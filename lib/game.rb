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
    @current_player.do_action
  end

  def next_player!
    current_idx = @players.index(@current_player)
    current_idx =+ 1
    current_idx = 0 if current_idx == @players.length
    @current_player = @players[current_idx]
  end

  def deal
    5.times do
      @players.each do |player|
        player.hand.receive(@deck.deal!)
      end
    end
  end

  def game_over?
    @players.map(&:amount).reject(&:zero?).length == 1
  end
end
