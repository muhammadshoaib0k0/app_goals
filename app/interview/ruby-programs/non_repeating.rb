def first_unique(arr)
  counts = Hash.new(0)
  arr.each { |el| counts[el] += 1 }
  arr.find { |el| counts[el] == 1 }
end
  
puts first_unique([4, 5, 1, 2, 1, 4, 5])  # => 2
