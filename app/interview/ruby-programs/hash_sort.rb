h = {"a"=>1, "c"=>3, "b"=>2, "d"=>4}
puts Hash[h.sort]
hsh ={"a" => 1000, "b" => 10, "c" => 200000}
puts Hash[hsh.sort_by{|k,v| v}]
