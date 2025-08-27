def missing_number(array)
  n = array.length + 1
  expected_sum = n * (n + 1) / 2
  actual_sum = array.sum
  expected_sum - actual_sum
end
  
# Example usage:
arr = (1..100).to_a
arr.delete(57)  # simulate missing number
puts missing_number(arr)  # => 57
  