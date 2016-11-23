require 'rspec'
require 'hand'

describe Hand do
  subject(:hand) { Hand.new }

  let(:sa) { double('Ace Spade', suit: :spade, value: :a)}
  12.times do |i|
    let("s#{i + 2}") { double("#{i + 2} Spade", suit: :spade, value: "#{i + 2}".to_i)}
  end

  12.times do |i|
    let("h#{i + 2}") { double("#{i + 2} Heart", suit: :heart, value: "#{i + 2}".to_i)}
  end

  describe '#initialize' do
    it 'initializes with an empty hand' do
      expect(hand.cards).to eq([])
    end
  end

  describe '#receive' do
    it 'adds a card' do
      expect(hand.cards).to be_empty
      hand.receive(sa)
      expect(hand.cards).to include(sa)
    end
  end

  describe '#discard' do
    it 'remove the input card' do
      hand.receive(sa)
      expect(hand.cards.length).to eq(1)
      hand.discard(:spade, :a)
      expect(hand.cards).to be_empty
    end
  end

  describe '#hand_ranking' do
    it 'checks for straight flush' do
      hand.receive(sa)
      hand.receive(s13)
      hand.receive(s12)
      hand.receive(s11)
      hand.receive(s10)
      expect(hand.cards.length).to eq(5)
      expect(hand.hand_ranking).to eq(1)
    end

    it 'returns 2 for four of a kind'

    it 'returns 3 for a full house'

    it 'returns 4 for a flush' do
      hand.receive(sa)
      hand.receive(s13)
      hand.receive(s12)
      hand.receive(s11)
      hand.receive(s9)
      expect(hand.hand_ranking).to eq(4)
    end

    it 'returns 5 for a straight' do
      hand.receive(sa)
      hand.receive(h13)
      hand.receive(s12)
      hand.receive(s11)
      hand.receive(s10)
      expect(hand.hand_ranking).to eq(5)
    end

    it 'returns 6 for three of a kind'

    it 'returns 7 for two pairs'

    it 'returns 8 for one pair' do
      hand.receive(sa)
      hand.receive(h12)
      hand.receive(s12)
      hand.receive(s11)
      hand.receive(s8)
      expect(hand.hand_ranking).to eq(8)
    end

    it 'returns 9 for high card' do
      hand.receive(sa)
      hand.receive(h13)
      hand.receive(s12)
      hand.receive(s11)
      hand.receive(s8)
      expect(hand.hand_ranking).to eq(9)
    end
  end

end
