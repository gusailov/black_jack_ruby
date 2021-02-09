class Player
  attr_reader :name, :players_cards, :wallet

  def initialize(name)
    @name = name
    @wallet = 100
    @players_cards = []
  end

  def take_cards(cards)
    @players_cards.concat(cards)
  end

  def show_player_cards
    puts "Cards of #{name} : "
    @players_cards.each { |card| print card.name, '| ' }
    nil
  end

  def bet(qty)
    @wallet -= qty
  end

  def points_sum
    puts "Cards of #{name} : "
  end
end
