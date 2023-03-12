
# string = "Hello apple pie p" its return -1 also because both "hello" & "apple" have same num of repeating element .
# string = "hello pie" return the keyword pie 

def word_repeat(str)
    arr= []
    if str.split(" ").max_by { |s| s.length - s.chars.uniq.length} !=  str.split(" ").reverse.max_by { |s| s.length - s.chars.uniq.length}
      return -1
    else
     str.split(" ").max_by { |s| s.length - s.chars.uniq.length}
    end
end

puts word_repeat(string)