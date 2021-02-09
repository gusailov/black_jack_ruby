class Player
  attr_reader :name, :players_cards

  def initialize(name)
    @name = name
    @wallet = 100
    @players_cards = []
  end

  def take_cards(cards)
    @players_cards.concat(cards)
  end

  def show_players_cards
    puts "Cards of #{name} : "
    @players_cards.each { |card| print card.name, '| ' }
    nil
  end
end
