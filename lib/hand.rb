class Hand
  attr_reader :cards
  def initialize
    @cards = []
  end

  def receive(card)
    @cards << card
  end

  def discard(suit, value)
    @cards.reject! do |card|
      card.suit == suit && card.value == value
    end
  end

  def hand_ranking
    return 1 if straight_flush
    return 2 if four_of_a_kind
    return 3 if full_house
    return 4 if flush
    return 5 if straight
    return 6 if three_of_a_kind
    return 7 if two_pairs
    return 8 if one_pair
    # return for high card
    9
  end

  private

  def straight_flush
    straight && flush
  end

  def four_of_a_kind
    card_hash.values.count { |val| val == 4 } == 1
  end

  def full_house
    three_of_a_kind && one_pair
  end

  def flush
    suit = @cards.first.suit
    @cards.all? { |card| card.suit == suit }
  end

  def straight
    vals = (1..14).to_a.join

    values = card_values
    if values.include?(:a)
      values.delete(:a)
      values << 1
      values << 14
    end

    values = values.sort.each_cons(5).to_a

    values.any? do |hand|
      vals.include?(hand.join)
    end
  end

  def three_of_a_kind
    card_hash.values.count { |val| val == 3 } == 1
  end

  def two_pairs
    card_hash.values.count { |val| val == 2 } == 2
  end

  def one_pair
    card_hash.values.count { |val| val == 2 } == 1
  end

  def card_values
    @cards.map(&:value)
  end

  def card_hash
    hash = Hash.new(0)
    card_values.each { |card| hash[card] += 1 }
    hash
  end

end
