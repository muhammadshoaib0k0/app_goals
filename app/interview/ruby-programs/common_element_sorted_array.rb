def common_elements(arr1, arr2)
  i, j = 0, 0
  common = []

  while i < arr1.length && j < arr2.length
    if arr1[i] == arr2[j]
      common << arr1[i]
      i += 1
      j += 1
    elsif arr1[i] < arr2[j]
      i += 1
    else
      j += 1
    end
  end

  common
end

puts common_elements([1, 2, 4, 6], [2, 4, 6, 8])  # => [2, 4, 6]
