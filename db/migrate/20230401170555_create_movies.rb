# frozen_string_literal: true

class CreateMovies < ActiveRecord::Migration[7.0]
  def change
    create_table :movies do |t|
      t.string :title
      t.integer :year
      t.timestamps
      #  (For clarity when we’re working in the console, I’m deleting t.timestamps.
    end
  end
end
