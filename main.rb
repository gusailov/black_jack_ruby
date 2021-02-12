require_relative './modules/modules'
require_relative 'game'
require_relative 'card'
require_relative 'player'
# require_relative 'cargo_train'
# require_relative 'passenger_train'
# require_relative 'passenger_wagon'
# require_relative 'cargo_wagon'
# require_relative 'railroad'

SPADES = "\u2660".freeze
HEARTS = "\u2665".freeze
CLUBS = "\u2663".freeze
DIAMONDS = "\u2666".freeze

g = Game.new

g.run
