class CreateEmployees < ActiveRecord::Migration[7.0]
  def change
    create_table :employees do |t|
      t.string :name
      t.integer :manager_id, foreign_key: true

      t.timestamps
    end
  end
end
