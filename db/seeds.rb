# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


Movie.destroy_all
Comparison.destroy_all

amir = Movie.create(title: "Dangal", year: 2016)
shahrukh = Movie.create(title: "Rab na bana di jorri", year: 2008)
salman = Movie.create(title: "Dabangg", year: 2010)

Comparison.create(superior_movie_id: amir.id, inferior_movie_id: salman.id)
Comparison.create(superior_movie_id: salman.id, inferior_movie_id: shahrukh.id)