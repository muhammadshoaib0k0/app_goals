class Employee < ApplicationRecord
  # Example: A manager has many employees, but… a manager is also an employee! self join
  has_many :subordinates, class_name: :Employee, foreign_key: :manager_id
  belongs_to :manager, class_name: :Employee, optional: true
end
