class Course < ApplicationRecord
  belongs_to :school
  has_many :school_admins, through: :school

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  enum status: { draft: 0, active: 1, archived: 2 }
end
