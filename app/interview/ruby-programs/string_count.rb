str = 'This is a string'
counts = Hash.new(0)
str.each_char { |char| counts[char] += 1 }
puts count

# Question # 8 #return maximum repeating element in string
str = 'Thissdfisadfdg0989string'
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
