# bidding.rb

require_relative 'agent'
class Bidding
  require 'byebug'

  def initialize(agents)
    @agents = agents
    @bids = Hash.new(0) # Initialize bids with 0 for each agent
    @agents.each { |agent| @bids[agent.to_s] = 0 } # Ensure all agents have initialized bids
    @active_agents = agents.dup # Keep track of active agents
  end

  def run
    loop do
      highest_bid = get_highest_bid
      all_matched = false
      agents_to_remove = []

      @active_agents.each do |agent|
        current_bid = @bids[agent]

        bid_increase = agent.get_bid_increase
        new_bid = current_bid + bid_increase

        puts "Agent::#{agent} ==> New Bid::#{new_bid} Highest Bid::#{highest_bid}"
        if new_bid >= highest_bid
          @bids[agent] = new_bid
          highest_bid = new_bid if new_bid > highest_bid
        else
          agents_to_remove << agent
        end

        all_matched = (@active_agents.count - agents_to_remove.count == 1)
      end

      @active_agents -= agents_to_remove

      puts ''

      break if all_matched
    end

    puts "\nOutput"
    puts "Highest Big => #{get_highest_bid}"
    puts "Winner Agent => #{@active_agents.first}"
    @bids
  end

  private

  def get_highest_bid
    @bids.values.max || 0
  end
end

# Example usage:
agents = [Agent.new('Agent 1'), Agent.new('Agent 2'), Agent.new('Agent 3')]
bidding = Bidding.new(agents)
final_bids = bidding.run

puts "\nAgents Details with their bids:"
final_bids.drop(3).sort_by { |_k, v| v }.each do |agent, bid|
  puts "#{agent}: #{bid}"
end