class Game
  attr_reader :cards_deck, :players, :bank, :player, :dealer

  def initialize
    @cards_deck = []
    cards_deck_create
    @players = []
    create_players
    @bank = 0
  end

  def run
    first_stage
    command = ''
    while command != 0
      command = gets.to_i
      case command
      when 1 then skip_stage
      when 2 then add_card
      when 3 then showdown
      when 4 then first_stage
      when 0 then break
      else
        puts 'Команда введена не правильно'
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
    puts 'Make Choice: 1-Skip, 2-Add card, 3-Showdown'
    @players.each(&:showdown) # ubrat'
  end

  def skip_stage
    @dealer.take_cards(cards_deck.pop(1)) if @dealer.points <= 17
    puts 'Your turn: 2-Add card, 3-Showdown'
    # @players.each(&:showdown)
    # @dealer.player_info
    @players.each(&:player_info)
  end

  def add_card
    @player.take_cards(cards_deck.pop(1))
    skip_stage
    @players.each(&:player_info)
    game_result
  end

  def showdown
    puts 'Showdown'
    @players.each(&:player_info)
    game_result
  end

  def game_result
    puts 'DRAW, no one wins' if @player.points == @dealer.points
    puts 'Player info before'
    @players.each(&:player_info)
    winner = if @player.points > 21 || (@player.points < @dealer.points && @dealer.points < 21)
               @dealer
             else
               @player
             end
    winner.wallet += bank
    @players.each(&:showdown)
    @players.each(&:player_info)

    puts 'WINNERR IS:'
    winner.player_info
    @players.each(&:clear)
    cards_deck_create
    @bank = 0
    puts 'new game - 4, stop - 0'
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
    puts 'Enter Your Name'
    name = gets.chomp.to_s
    @player = Player.new(name)
    @dealer = Player.new('Dealer')
    @players = [@player, @dealer]
  end
end
