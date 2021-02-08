class Game
  attr_reader :cards_deck

  def initialize
    @cards_deck = []
    @suits = [SPADES, HEARTS, CLUBS, DIAMONDS]
    seed
  end

  def seed
    ranked_cards = %w[A K Q J]
    @suits.each do |suit|
      (2..10).each { |i| @cards_deck << Card.new(suit, i, i) }
      ranked_cards.each { |i| @cards_deck << Card.new(suit, i, 10) }
    end
  end
end
