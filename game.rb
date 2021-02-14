class Game
  attr_reader :cards_deck, :players, :bank, :player, :dealer

  SPADES = "\u2660".freeze
  HEARTS = "\u2665".freeze
  CLUBS = "\u2663".freeze
  DIAMONDS = "\u2666".freeze

  def initialize
    @cards_deck = []
    cards_deck_create
    @players = []
    create_players
    @bank = 0
  end

  def run
    first_stage
    puts 'Make Choice: 1-Skip, 2-Add card, 3-Showdown'
    @command = ''
    while @command != 0
      @command = gets.to_i
      case @command
      when 1
        skip_stage
        puts 'Your turn: 2-Add card, 3-Showdown'
      when 2 then add_card
      when 3 then game_result
      when 0 then break
      else
        puts 'Invalid command'
      end
    end
  end

  private

  def first_stage
    bet = 10
    @bank += 2 * bet
    @players.each do |player|
      player.take_cards(cards_deck.pop(2))
      player.bet(bet)
      player.player_info
    end
  end

  def skip_stage
    return unless @dealer.points <= 17 && @dealer.players_cards.values.count < 3

    @dealer.take_cards(cards_deck.pop(1))
  end

  def add_card
    @player.take_cards(cards_deck.pop(1))
    skip_stage
    game_result
  end

  def game_result
    @dealer.showdown = true
    filtered_players = @players.select { |p| p.points <= 21 }
    if @player.points == @dealer.points || filtered_players.empty?
      puts 'DRAW, no one wins'
      @players.each { |player| player.wallet += (bank / 2) }
      @players.each(&:player_info)
    else
      winner = filtered_players.each.max { |a, b| a.points <=> b.points }
      show_winner(winner)
    end
    @command = 0
    renew
  end

  def renew
    @players.each(&:clear)
    cards_deck_create
    @bank = 0
    @dealer.showdown = false
    command = ''
    while command != 0
      puts 'NEW GAME- 1, STOP - 0'
      command = gets.to_i
      case command
      when 1
        run
        break
      when 0 then break
      else
        puts 'Invalid command'
      end
    end
  end

  def show_winner(winner)
    @players.each(&:player_info)
    winner.wallet += bank
    puts 'WINNERR IS:'
    winner.player_info
  end

  def cards_deck_create
    ranked_cards = %w[J Q K]
    [SPADES, HEARTS, CLUBS, DIAMONDS].each do |suit|
      (2..10).each { |i| @cards_deck << Card.new(suit, i, i) }
      ranked_cards.each { |i| @cards_deck << Card.new(suit, i, 10) }
      @cards_deck << Card.new(suit, 'A', 1)
    end
    @cards_deck = @cards_deck.shuffle
  end

  def create_players
    name = ''
    while name !~ /^\S+$/
      puts 'Enter Your Name'
      name = gets.chomp.to_s
      @player = Player.new(name)
      @dealer = Player.new('Dealer')
      @dealer.showdown = false
      @players = [@player, @dealer]
    end
  end
end
