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
    card_names = []
    @players_cards.each do |card|
      card_names << card.name.to_s
    end
    card_names.join('|')
  end

  def player_info
    puts "Player: #{name}, cards: |#{show_player_cards}|, wallet: #{wallet} "
  end

  def bet(qty)
    @wallet -= qty
  end

  def points_sum
    card_values = []
    if @players_cards.any? { |card| card.rank == 'A' }
      @players_cards.each do |card|
        card_values << card.value
      end
      puts "AAAA #{card_values.sum}"
    else
      @players_cards.each do |card|
        card_values << card.value
      end
      puts "FFF #{card_values.sum}"
    end
  end
end
