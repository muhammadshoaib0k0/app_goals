# frozen_string_literal: true

class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.string :description, limit: 200
      t.boolean :completed, default: false

      t.timestamps
    end
  end
end
