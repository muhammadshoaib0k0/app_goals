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
