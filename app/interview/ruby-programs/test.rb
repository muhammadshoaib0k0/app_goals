
# https://www.interviewbit.com/ruby-on-rails-interview-questions/
# https://www.youtube.com/watch?v=XzM6MwBJyDE
# https://www.ideamotive.co/ruby-on-rails/interview
# https://dev.to/isalevine/let-s-use-rails-partial-views-to-render-art-from-magic-the-gathering-cards-5d8l

# Question # 8 #return maximum repeating element in string
str = "Thissdfisadfdg0989string" 
def max_occuring_char(str)
  char_count = Hash.new(0)
  
  str.each_char do |char|
    char_count[char] += 1
  end
  
  max_char = ''
  max_count = 0
  
  char_count.each do |char, count|
    if count > max_count
      max_char = char
      max_count = count
    end
  end
  
  max_char
end
#  Submission task

# Exercise:

# Complete the given Bidding class that will be used for a bidding system.

class Agent
  # This will already be implemented and is not part of this exercise
  def initialize; end

  # This will return the amount (integer) by which the agent wants to increase its bid
  # (i.e. how much they want to add onto their bid as it stands so far)
  # This will already be implemented and is not part of this exercise
  def get_bid_increase; end
end


class Bidding
  def initialize(agents)
    @agents = agents
    # TODO: any other initialisation you need
  end

  def run
    # TODO
  end

  # TODO (optional): add any other methods (with implementation) you find useful
end

#   Implement the sections of code marked TODO above.

#   Rules for bidding:
#   Agents always bid in sequence, e.g. agent 1 bids first, then agent 2, etc.
#   The bidding starts with the first agent deciding on their initial bid (which will be returned by `get_bid_increase`). The amount can also be 0.
#   The next agent (e.g. agent 2) must then increase their bid so that their bid is as much as any other agent's bid (which so far is only agent 1), or be forced to withdraw from the bidding completely. (if the agent has withdrawn, they will be skipped from here onwards). They may also decide to bid more, in which case the next agent has to match that higher bid (or withdraw).
#   The bidding will come around to agent 1 again if their current bid does not match the highest bid. The agent must increase their bid (by returning the value they want to increase it by from `getBidIncrease`) so that their bid will match the highest bid that any other agent has put in so far, or withdraw from the bidding. They can also have the option to decide to bid more, same as discussed above.
#   Keep in mind that the bidding can circle the group of agents more than once, depending on if agents up their bids. Each agent who wishes to proceed is required to have committed a bid that is equal to the highest bid made by any other agent, counted over the duration of the bidding process. NB: The bidding will end immediately once this condition is met - an agent is not allowed to up their bid once everyone else has matched them.
#   There can be multiple agents left at the end of bidding process, all with the same bid. That will be handled by a second bidding process that's outside the scope of this exercise.

#   Hints:
# - Be sure you understand the above bidding rules clearly.
# - Do not implement a literal solution to the problem, i.e. don't read each line on its own and write code just for that part of the requirements. Rather, think about it holistically so you can come up with a solution that meets all the requirements.
# - No consideration should be paid to performance - clear, readable code is more imporant in this exercise.


# Assesment # 2

# Here's an example from one of our devs on a task thats next on our list. It'd be good to hear how you'd approach and if it would be something you'd feel comfortable taking on:
# We need an extendable (and updated) version of JSONPath for ruby https://github.com/joshbuddy/jsonpath that supports functions like concat, map, etc like the JayWay version (written in Java)
# # https://github.com/json-path/JsonPath
# Also I was thinking that this could be a lambda funciton that takes a JSON as an argument and returns the fixed JSON using JayWay JsonPath
# one thing we want to be able to do is, based on this JSON:
# {
# "coordinates": {
# "0": {
# "x": "230",
# "y": "154"
# },
# "1": {
# "x": "422",
# "y": "154"
# },
# "2": {
# "x": "422",
# "y": "394"
# },
# "3": {
# "x": "230",
# "y": "394"
# }
# }
# }
# We want to do transformations that will allow us to get this string
# x0,y0 x1,y1 x2,y2 x3,y3
# ie
# "230,154 422,154 422,394 230,394"

# Question Sort by keys, and return array of values only
input = {"john": 23, "james": 24, "vincent": 34, "louis": 29}

sorted_values = input.sort_by{ |key, value| key }.map{ |key, value| value }

puts sorted_values
