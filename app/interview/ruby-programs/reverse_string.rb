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
