# frozen_string_literal: true

array = [5, 5, 5, 4, 3, 2, 4, 3, 2, 1]
result = Hash[array.uniq.map { |v| [v, array.count(v)] }]
puts result

puts array.tally

def score(array)
  hash = Hash.new(0)
  array.each { |key| hash[key] += 1 }
  hash
end

score(array)
