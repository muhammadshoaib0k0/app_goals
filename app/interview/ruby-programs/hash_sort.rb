# frozen_string_literal: true

h = { 'a' => 1, 'c' => 3, 'b' => 2, 'd' => 4 }
puts Hash[h.sort]
hsh = { 'a' => 1000, 'b' => 10, 'c' => 200_000 }
puts Hash[hsh.sort_by { |_k, v| v }]

# Question Sort by keys, and return array of values only
input = { "john": 23, "james": 24, "vincent": 34, "louis": 29 }

sorted_values = input.sort_by { |key, _value| key }.map { |_key, value| value }

puts sorted_values
