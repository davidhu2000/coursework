require 'rspec'
require 'tdd'
require 'stringio'

describe Array do
  describe '#my_uniq' do
    let(:array) { [1, 2, 3, 3, 4] }
    let(:no_dup) { [1, 2, 3, 4] }

    it "should remove duplicates" do
      expect(array.my_uniq).to eq([1, 2, 3, 4])
    end

    it "should not remove elements" do
      expect(no_dup.my_uniq).to eq([1, 2, 3, 4])
    end

    it "should not modify original array" do
      array.my_uniq
      expect(array).to eq([1, 2, 3, 3, 4])
    end
  end

  describe '#two_sum' do
    let (:array) { [-1, 1, 1, 2, 0] }

    it "should return an array" do
      expect(array.two_sum).to be_an_instance_of(Array)
    end

    it "should return an array containing [[0, 1], [0, 2]" do
      expect(array.two_sum).to eq([[0, 1], [0, 2]])
    end


  end

  describe '#my_transpose' do
    let(:rows) { [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8]
    ]}

    let(:cols) {[
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8]
    ]}

    it "should return an array" do
      expect(rows.my_transpose).to be_an_instance_of(Array)
    end

    it "should tranpose the array" do
      expect(rows.my_transpose).to eq(cols)
    end

    it "should not modify original array" do
      original = rows
      rows.my_transpose
      expect(rows).to eq(original)
    end
  end
end

describe '#stock_picker' do
  let(:prices) { [5, 4, 7, 1, 3, 9] }

  it "should return an array of two values" do
    best_buy = stock_picker(prices)
    expect(best_buy).to be_an_instance_of(Array)
    expect(best_buy.length).to eq(2)
  end

  it "should return the best days to buy and sell" do
    expect(stock_picker(prices)).to eq([3, 5])
  end
end


describe TowersOfHanoi do
  subject(:game) { TowersOfHanoi.new }

  describe '#initialize' do
    it 'should return an array of length 3' do
      expect(game.towers.length).to eq(3)
    end

    it 'should initialize towers in the first array' do
      expect(game.towers.first).to eq([3, 2, 1])
    end

    it 'should initialize last two arrays to be empty' do
      expect(game.towers[1]).to be_empty
      expect(game.towers[2]).to be_empty
    end
  end

  describe '#get_input' do
    context "Invalid moves" do
      after do
        $stdin = STDIN
      end

      it 'should raise "No disc in starting position"' do
        $stdin = StringIO.new("1, 2\n")
        expect { game.get_input }.to raise_error("No disc in starting position")
      end

      it 'should raise "Not valid position"' do
        $stdin = StringIO.new("4, 0\n")
        expect { game.get_input }.to raise_error("Not valid position")
      end

      it 'should raise "Cannot place larger disk onto smaller disk"' do
        game.towers[1] << game.towers[0].pop
        $stdin = StringIO.new("0, 1\n")
        expect { game.get_input }.to raise_error("Cannot place larger disk onto smaller disk")
      end

    end
  end

  describe '#move' do
    it 'should move disc' do
      game.move([0,1])
      expect(game.towers).to eq([[3, 2], [1], []])
    end
  end

  describe '#won' do
    it 'returns true if won' do
      game.towers = [[],[3,2,1],[]]
      expect(game.won?).to be true
    end

    it 'returns false if have not won' do
      game.towers = [[3],[2,1],[]]
      expect(game.won?).to be false
    end
  end

end
