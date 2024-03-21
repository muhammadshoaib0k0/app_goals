# frozen_string_literal: true

class Comparison < ApplicationRecord
  belongs_to :superior_movie, class_name: 'Movie'
  belongs_to :inferior_movie, class_name: 'Movie'
  # Triple-Join after addming user_id in comparison
  # This table displays two users with opposite opinions.
  # User 1 creates the same hierarchy with which we’ve been working (movie 1 is superior to 3, which is superior to 2). User 2 has the reverse opinion: they think that movie 1 is inferior to movie 3, which is inferior to movie 2.
  belongs_to :user, class_name: 'User'
end
