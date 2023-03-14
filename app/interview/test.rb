
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