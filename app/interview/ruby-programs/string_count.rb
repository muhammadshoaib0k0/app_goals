str = "This is a string"
counts = Hash.new(0)
str.each_char { |char| counts[char] += 1 }
puts count
