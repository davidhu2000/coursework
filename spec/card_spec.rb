require 'rspec'
require 'card'

describe Card do
  subject(:card) { Card.new(:a, :spade) }

  describe '#initialize' do
    it 'should initialize card value' do
      expect(card.value).to eq(:a)
    end

    it 'should initialize card suit' do
      expect(card.suit).to eq(:spade)
    end
    
  end
end
