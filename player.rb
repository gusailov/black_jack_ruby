class Player
  attr_reader :name

  def initialize(name)
    @name = name
    @wallet = 100
  end
end
