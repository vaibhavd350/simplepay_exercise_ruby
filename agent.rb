# agent.rb

class Agent
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def get_bid_increase
    rand(1..10)  # Example: Random increase between 1 and 10
  end

  def to_s
    @name
  end
end
