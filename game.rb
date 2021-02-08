class Game
  attr_reader :cards_deck

  def initialize
    @cards_deck = []
    @suits = [SPADES, HEARTS, CLUBS, DIAMONDS]
    seed
  end

  def seed
    ranked_cards = %w[J Q K]
    @suits.each do |suit|
      (2..10).each { |i| @cards_deck << Card.new(suit, i, i) }
      ranked_cards.each { |i| @cards_deck << Card.new(suit, i, 10) }
      @cards_deck << Card.new(suit, 'A', 1)
    end
  end
end
