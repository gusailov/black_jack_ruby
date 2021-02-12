class Player
  attr_reader :name, :players_cards, :points
  attr_accessor :wallet

  def initialize(name)
    @name = name
    @wallet = 100
    @players_cards = {}
    @showdown = false
  end

  def take_cards(cards)
    cards.each { |card| @players_cards[card.name] = card.value }
  end

  def player_info
    points_sum
    if name == 'Dealer' && !@showdown
      puts "Dealer, cards: **, points: **, wallet: #{wallet} "
    else
      puts "#{name}, cards: |#{players_cards.keys.join('|')}|, points: #{points}, wallet: #{wallet} "
    end
  end

  def bet(qty)
    @wallet -= qty
  end

  def showdown
    @showdown = true
  end

  def points_sum
    @points = if players_cards.values.any? { |value| value == 1 } && players_cards.values.sum <= 11
                (players_cards.values.sum + 10)
              else
                players_cards.values.sum
              end
  end
end
