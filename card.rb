class Card
  attr_reader :name, :value, :rank

  def initialize(suit, rank, value)
    @suit = suit
    @rank = rank
    @value = value
    @name = "#{rank}#{suit}"
  end
end
