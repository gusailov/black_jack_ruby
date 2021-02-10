class Game
  attr_reader :cards_deck, :player, :dealer, :bank

  def initialize
    @cards_deck = []
    cards_deck_create
    @dealer = Player.new('Dealer')
    @bank = 0
  end

  def run
    bet = 10
    create_player
    @player.take_cards(cards_deck.pop(2))
    @player.bet(bet)
    @bank += 2 * bet
    @dealer.take_cards(cards_deck.pop(2))
    @dealer.bet(bet)
    @player.points_sum
    @dealer.points_sum
    @player.player_info
    @dealer.player_info
  end

  private

  def cards_deck_create
    ranked_cards = %w[J Q K]
    [SPADES, HEARTS, CLUBS, DIAMONDS].each do |suit|
      (2..10).each { |i| @cards_deck << Card.new(suit, i, i) }
      ranked_cards.each { |i| @cards_deck << Card.new(suit, i, 10) }
      @cards_deck << Card.new(suit, 'A', 1)
    end
    @cards_deck = @cards_deck.shuffle
  end

  def create_player
    puts 'Enter Your Name'
    name = gets.chomp
    @player = Player.new(name)
  end
end
