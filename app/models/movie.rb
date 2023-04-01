class Movie < ApplicationRecord
    has_many :superior_comparisons, foreign_key: :superior_movie_id, class_name: "Comparison"
    has_many :inferior_comparisons, foreign_key: :inferior_movie_id, class_name: "Comparison"
end
# https://betterprogramming.pub/building-self-joins-and-triple-joins-in-ruby-on-rails-455701bf3fa7 implements a self-join, then triple-join relationship