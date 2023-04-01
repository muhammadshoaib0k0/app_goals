class Comparison < ApplicationRecord
   belongs_to :superior_movie, class_name: "Movie"
   belongs_to :inferior_movie, class_name: "Movie"
end
