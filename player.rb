class Player
  attr_reader :name, :players_cards, :wallet, :points, :card_values

  def initialize(name)
    @name = name
    @wallet = 100
    @players_cards = []
    @card_values = []
  end

  def take_cards(cards)
    @players_cards.concat(cards)
    card_values_count
  end

  def show_player_cards
    card_names = []
    @players_cards.each { |card| card_names << card.name.to_s }
    card_names.join('|')
  end

  def player_info
    points_sum
    puts "Player: #{name}, cards: |#{show_player_cards}|, points: #{points}, wallet: #{wallet} "
  end

  def bet(qty)
    @wallet -= qty
  end

  def points_sum
    @points = if @card_values.any? { |value| value == 1 } && @card_values.sum <= 11
                (@card_values.sum + 10)
              else
                @card_values.sum
              end
  end

  def card_values_count
    @players_cards.each do |card|
      @card_values << card.value
      # unless @players_cards.include?(card)
    end
  end
end
