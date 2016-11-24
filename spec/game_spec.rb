require 'rspec'
require 'game'

describe Game do

  let(:hand1) { double("hand1", cards: [])}
  let(:hand2) { double("hand2", cards: [])}
  let(:hand3) { double("hand3", cards: [])}
  let(:player1) { double('player1', name: "Fred", amount: 1000, hand: hand1) }
  let(:player2) { double('player2', name: "George", amount: 1000, hand: hand2) }
  let(:player3) { double('player3', name: "Ron", amount: 1000, hand: hand3) }

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
      allow(hand1).to receive(receive).
      game.deal
      [player1, player2, player3].each do |player|
        expect(player.hand.cards.length).to eq(5)
      end
      expect(deck.cards.length).to eq(37)
    end
  end

  describe '#take_turn' do
    it 'should receive an action from player'
  end

end
