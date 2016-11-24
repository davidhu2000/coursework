require 'rspec'
require 'player'

describe Player do
  let(:hand) { double("Hand", cards: [])}
  subject(:player) { Player.new('Johnson', 1000)}
  let(:sa) { double("Ace space", suit: :spade, value: :a)}

  5.times do |i|
    let("s#{i + 9}") do
      double("#{i + 9} Spade", suit: :spade, value: "#{i + 9}".to_i)
    end
  end

  describe '#initialize' do
    it 'should initialize with player name' do
      expect(player.name).to eq('Johnson')
    end

    it 'should initialize hand' do
      expect(player.hand).to be_a(Hand)
      expect(player.hand.cards).to be_empty
    end

    it 'should initialize starting amount' do
      expect(player.amount).to eq(1000)
    end
  end

  describe '#get_discard' do
    before(:each) do
      player.hand.cards << s9
      player.hand.cards << s13
      player.hand.cards << sa
    end

    after do
      $stdin = STDIN
    end

    it 'raises an error if card is not part of hand' do
      $stdin = StringIO.new('heart, 3')
      expect { player.get_discard }.to raise_error('card not in hand')
    end

    it 'returns an array with suit and ace value' do
      $stdin = StringIO.new('spade, a')
      expect(player.get_discard).to eq([:spade, :a])
    end

    it 'returns an array with suit and numeric value' do
      $stdin = StringIO.new('spade, 13')
      expect(player.get_discard).to eq([:spade, 13])
    end

  end

  describe '#discard_card' do
    before(:each) do
      player.hand.cards << s9
      player.hand.cards << s13
      player.hand.cards << s12
      player.hand.cards << s11
      player.hand.cards << s10
    end

    it 'discard the card' do
      expect(player.hand.cards).to include(s9)

      $stdin = StringIO.new('spade, 9')
      player.discard_card

      expect(player.hand.cards).to_not include(s9)
    end

  end

end
