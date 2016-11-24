require 'rspec'
require 'game'
require 'player'

describe Game do

  let(:player1) { Player.new("Player1", 1000) }
  let(:player2) { Player.new("Player2", 1000) }
  let(:player3) { Player.new("Player3", 1000) }

  subject(:game) { Game.new([player1, player2, player3]) }

  describe '#initialize' do
    it 'should initialize with a deck' do
      expect(game.deck).to be_a(Deck)
    end

    it 'should accept an array of players' do
      expect(game.players).to be_an(Array)
      expect(game.players.length).to eq(3)
    end

    it 'should set the current_player as first player' do
      expect(game.current_player).to eq(player1)
    end

    it 'should set the pot to 0' do
      expect(game.pot).to eq(0)
    end
  end

  describe '#deal' do
    it 'should deal 5 cards to each player' do
      game.deal
      [player1, player2, player3].each do |player|
        expect(player.hand.cards.length).to eq(5)
      end
      expect(game.deck.cards.length).to eq(37)
    end
  end

  describe '#take_turn' do
    it 'should receive an action from player' do
      expect(game.current_player).to receive(:do_action)
      game.take_turn
    end
  end

  describe '#next_player' do
    it 'should change the player' do
      expect(game.current_player).to eq(player1)
      game.next_player!
      expect(game.current_player).to_not eq(player1)
    end
  end

  describe '#game_over?' do
    it 'return true if only have player have money' do
      expect(game.game_over?).to be false
      player2.amount = 0
      player3.amount = 0
      expect(game.game_over?).to be true 
    end
  end

end
