# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Movie.destroy_all
Comparison.destroy_all
User.destroy_all

shoaib = User.create(name: 'Shoaib')
ahmed = User.create(name: 'Ahmed')

amir = Movie.create(title: 'Dangal', year: 2016)
shahrukh = Movie.create(title: 'Rab na bana di jorri', year: 2008)
salman = Movie.create(title: 'Dabangg', year: 2010)
# Seed data for self join where user id is not in comparison table
# Comparison.create(superior_movie_id: amir.id, inferior_movie_id: salman.id)
# Comparison.create(superior_movie_id: salman.id, inferior_movie_id: shahrukh.id)

# Seed data for Triple join where user id is in the comparison table, two different user have different reverse opinion
Comparison.create(user_id: shoaib.id, superior_movie_id: amir.id, inferior_movie_id: salman.id)
Comparison.create(user_id: shoaib.id, superior_movie_id: salman.id, inferior_movie_id: shahrukh.id)
Comparison.create(user_id: ahmed.id, superior_movie_id: salman.id, inferior_movie_id: amir.id)
Comparison.create(user_id: ahmed.id, superior_movie_id: shahrukh.id, inferior_movie_id: salman.id)
