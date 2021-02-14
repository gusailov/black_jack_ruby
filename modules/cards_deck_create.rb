module CardsDeck
  SPADES = "\u2660".freeze
  HEARTS = "\u2665".freeze
  CLUBS = "\u2663".freeze
  DIAMONDS = "\u2666".freeze

  def cards_deck_create
    ranked_cards = %w[J Q K]
    [SPADES, HEARTS, CLUBS, DIAMONDS].each do |suit|
      (2..10).each { |i| @cards_deck << Card.new(suit, i, i) }
      ranked_cards.each { |i| @cards_deck << Card.new(suit, i, 10) }
      @cards_deck << Card.new(suit, 'A', 1)
    end
    @cards_deck = @cards_deck.shuffle
  end
end
