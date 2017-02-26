require 'rspec'
require 'deck'

describe Deck do

  subject(:deck) { Deck.new }

  describe '#initialize' do

    it 'should create an array of 52 instances of Card' do
      expect(deck.cards).to be_an(Array)
      expect(deck.cards.length).to eq(52)
      expect(deck.cards[rand(52)]).to be_a(Card)
    end

    context "Deck has the right cards" do
      it "has 13 cards per suit" do
        [:spade, :heart, :club, :diamond].each do |suit|
          suit_count = deck.cards.count { |card| card.suit == suit }
          expect(suit_count).to eq(13)
        end
      end

      it "has 4 cards per value" do
        [:a, 2, 3, 4, 5, 6, 7, 8, 9, :t, :j, :q, :k].each do |value|
          value_count = deck.cards.count { |card| card.value == value }
          expect(value_count).to eq(4)
        end
      end
    end
  end

  describe '#shuffle!' do
    it 'should shuffle the deck' do
      original = deck.cards.dup
      deck.shuffle!
      expect(deck.cards).to_not eq(original)
    end
  end

  describe '#deal!' do
    it 'should deal one card from cards' do
      expect(deck.cards.length).to eq(52)
      deck.deal!
      expect(deck.cards.length).to eq(51)
    end

    it 'should return the first card' do
      first_card = deck.cards.first
      expect(deck.deal!).to eq(first_card)
    end
  end

  describe '#reshuffle' do
    before(:each) { 20.times { deck.deal! } }

    it 'should reshuffle the deck' do
      expect(deck).to receive(:shuffle!)
      expect(deck.cards.length).to eq(32)
      deck.reshuffle!
      expect(deck.cards.length).to eq(52)
    end
  end
end
