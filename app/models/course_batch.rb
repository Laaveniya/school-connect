class CourseBatch < ApplicationRecord
  belongs_to :creator, class_name: 'User'
  belongs_to :course
  has_one :school, through: :course, source: :school

  validates :name, presence: true, uniqueness: true
  validates :max_enrollment_count, presence: true, numericality: { greater_than: 0 }
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :course_id, presence: true
end
