# Question # 3

def check_dup(arr)
  return -1 if arr.max_by { |i| arr.count(i) } != arr.reverse.max_by { |i| arr.count(i) }

  arr.max_by { |i| arr.count(i) }
end

puts check_dup([1, 2, 2, 3, 4, 4]) # return -1
puts check_dup([1, 2, 2, 3, 3, 3, 3, 4, 4]) # return 3
