
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
