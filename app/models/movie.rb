# frozen_string_literal: true

class Movie < ApplicationRecord
  # Important through association
  has_many :superior_comparisons, foreign_key: :superior_movie_id, class_name: 'Comparison'
  has_many :inferior_movies, through: :superior_comparisons

  has_many :inferior_comparisons, foreign_key: :inferior_movie_id, class_name: 'Comparison'
  has_many :superior_movies, through: :inferior_comparisons

  # Triple join

  # From a movie, we should have access to the users that are “fans”
  # of the movie (i.e. users who put the movie in the superior_movie_id column),
  #  as well as those users that are “haters”.
  has_many :fans, through: :superior_comparisons, source: :user
  has_many :haters, through: :inferior_comparisons, source: :user
end
# https://betterprogramming.pub/building-self-joins-and-triple-joins-in-ruby-on-rails-455701bf3fa7 implements a self-join, then triple-join relationship
