class Player
  attr_reader :name, :players_cards, :points
  attr_accessor :wallet, :showdown

  def initialize(name)
    @name = name
    @wallet = 100
    @players_cards = {}
    @showdown = true
  end

  def take_cards(cards)
    cards.each { |card| @players_cards[card.name] = card.value }
    points_sum
  end

  def player_info
    if @showdown
      puts "#{name}, cards: |#{players_cards.keys.join('|')}|, points: #{points}, wallet: #{wallet} "
    else
      puts "#{name}, cards: **, points: **, wallet: #{wallet} "
    end
  end

  def bet(qty)
    @wallet -= qty
  end

  def clear
    @players_cards = {}
  end

  private

  def points_sum
    @points = if players_cards.values.include?(1) && players_cards.values.sum <= 11
                (players_cards.values.sum + 10)
              else
                players_cards.values.sum
              end
  end
end
