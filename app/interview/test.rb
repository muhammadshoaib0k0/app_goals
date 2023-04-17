
# https://www.interviewbit.com/ruby-on-rails-interview-questions/
# https://www.youtube.com/watch?v=XzM6MwBJyDE
# https://www.ideamotive.co/ruby-on-rails/interview
# https://dev.to/isalevine/let-s-use-rails-partial-views-to-render-art-from-magic-the-gathering-cards-5d8l
# string = "Hello apple pie p" its return -1 also because both "hello" & "apple" have same num of repeating element .
# string = "hello pie" return the keyword pie 
# Question # 1
def word_repeat(str)
  arr= []
  if str.split(" ").max_by { |s| s.length - s.chars.uniq.length} !=  str.split(" ").reverse.max_by { |s| s.length - s.chars.uniq.length}
    return -1
  else
    str.split(" ").max_by { |s| s.length - s.chars.uniq.length}
  end
end

puts word_repeat(string)


# Question # 2

array = [5,5,5,4,3,2,4,3,2,1]
result = Hash[array.uniq.map{ |v| [v, array.count(v)]}]
puts result

puts array.tally

def score( array )
  hash = Hash.new(0)
  array.each{|key| hash[key] += 1}
  hash
end

score(array)

# Question # 3

def check_dup(arr)
  if arr.max_by { |i| arr.count(i) } != arr.reverse.max_by { |i| arr.count(i) }
    return -1
  else
    arr.max_by { |i| arr.count(i) }
  end
end

puts check_dup([1,2,2,3,4,4]) # return -1
puts check_dup([1,2,2,3,3,3,3,4,4]) #return 3

# Question # 4

array = [1,24,0,[3,5,6],7]
def recur_flatten(array, results=[])
  array.each do |ele|
    if ele.class == Array
      recur_flatten(ele, results)
    else
      results << ele  
    end
  end
  results
end

puts recur_flatten(array)

# Question # 5

h = {"a"=>1, "c"=>3, "b"=>2, "d"=>4}
puts Hash[h.sort]
hsh ={"a" => 1000, "b" => 10, "c" => 200000}
puts Hash[hsh.sort_by{|k,v| v}]



# Question # 6

# Example usage
puts reverse_string("hello, world!") # prints def reverse_string(str)
  # Convert the string to an array of characters
  arr = str.chars

  # Use two pointers to reverse the array in place
  left = 0
  right = arr.length - 1
  while left < right
    if !arr[left].match?(/[a-zA-Z]/)
      left += 1
    elsif !arr[right].match?(/[a-zA-Z]/)
      right -= 1
    else
      arr[left], arr[right] = arr[right], arr[left]
      left += 1
      right -= 1
    end
  end

  # Convert the array back to a string and return it
  arr.join("")
end

# Example usage
puts reverse_string("hello, world!") # prints "!dlrow ,olleh" 

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