require 'rspec'
require 'deck'

describe Deck do
  subject(:deck) { Deck.new }

  describe '#initialize' do

    it 'should create an array of 52 instance of Card' do
      expect(deck.cards).to be_an(Array)
      expect(deck.cards.length).to eq(52)
      expect(deck.cards.first).to be_a(Card)
    end

  end
end
