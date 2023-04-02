class CreateComparisons < ActiveRecord::Migration[7.0]
  def change
    create_table :comparisons do |t|
      t.integer :superior_movie_id, foreign_key: true
      t.integer :inferior_movie_id, foreign_key: true
      t.integer :user_id, foreign_key: true
      t.timestamps
    end
  end
end
